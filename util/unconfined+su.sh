#!/bin/bash

exec newrole -r unconfined_r -- -c '/bin/su -'
