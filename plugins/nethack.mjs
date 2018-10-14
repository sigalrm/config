// Copyright © 2018 TermySequence LLC
// SPDX-License-Identifier: CC0-1.0
// This file is free to build upon, enhance, and reuse, without restriction.

var nextGarbage = 0;

function nameGarbageHandler(manager) {
    let term = manager.getActiveTerminal();
    if (!term)
        return;

    let name = 'garbage' + nextGarbage++;
}

if (plugin.majorVersion != 1 || plugin.minorVersion < 2) {
    throw new Error("unsupported API version");
}

plugin.pluginName = 'NethackActionsPlugin';
plugin.pluginDescription = 'Various nethack-related input macros';
plugin.pluginVersion = '1.0';

plugin.registerCustomAction(1, 'NethackNameGarbage', nameGarbageHandler)
