#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

static void
bail(const char *msg)
{
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int
main(int argc, char *const argv[], char *const envp[])
{
	int p1[2], p2[2];
	char *a1[4], *a2[4];
	char prog[] = "/usr/lib64/xen/bin/xenconsole";
	pid_t pid, c1, c2;
	int status;

	if (argc != 3)
		bail("Usage: pipe2 <guest1> <guest2>");

	a1[0] = prog;
	//a1[1] = "console";
	a1[1] = argv[1];
	a1[2] = NULL;

	a2[0] = prog;
	//a2[1] = "console";
	a2[1] = argv[2];
	a2[2] = NULL;

	if (pipe(p1) < 0)
		bail("pipe() call failed!");
	if (pipe(p2) < 0)
		bail("pipe() call failed!");

	c1 = fork();
	if (c1 == 0) {
		close(0);
		close(1);
		close(2);
		close(p1[1]);
		close(p2[0]);

		dup2(p1[0], 0);
		dup2(p2[1], 1);
		dup2(p2[1], 2);

		close(p2[1]);
		close(p1[0]);

		execve(prog, a1, envp);
	}

	c2 = fork();
	if (c2 == 0) {
		close(0);
		close(1);
		close(2);
		close(p2[1]);
		close(p1[0]);

		dup2(p2[0], 0);
		dup2(p1[1], 1);
		dup2(p1[1], 2);

		close(p1[1]);
		close(p2[0]);

		execve(prog, a2, envp);
	}

	pid = waitpid(-1, &status, 0);
	fprintf(stderr, "%d exit %d\n", pid, status);
	pid = waitpid(-1, &status, 0);
	fprintf(stderr, "%d exit %d\n", pid, status);

	return 0;
}
