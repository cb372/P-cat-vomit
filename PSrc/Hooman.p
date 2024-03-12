event eFillBowl;
event eTickWhiteboardIfNotAlreadyTicked: Hooman;

machine Hooman {
    var bowl: Bowl;
    var whiteboard: Whiteboard;

    start state Init {
        entry (input: (b: Bowl, w: Whiteboard, useWhiteboard: bool)) {
            bowl = input.b;
            whiteboard = input.w;

            if (input.useWhiteboard) {
                goto UsingWhiteboard;
            } else {
                goto NoWhiteboard;
            }
        }

        defer eShutDown;
    }

    state UsingWhiteboard {
        entry {
            // Try to put a tick on the whiteboard (compare-and-set)
            send whiteboard, eTickWhiteboardIfNotAlreadyTicked, this;
        }

        on eWhiteboardWasAlreadyTicked do (wasAlreadyTicked: bool) {
            if (!wasAlreadyTicked) {
                // Nobody has fed the cat yet, so fill the bowl with food
                send bowl, eFillBowl;
            }
        }

        on eShutDown do {
            raise halt;
        }
    }

    state NoWhiteboard {
        entry {
            // Unconditionally feed the cat.
            // I hope nobody else has already fed her, or this could get messy!
            send bowl, eFillBowl;
        }

        on eShutDown do {
            raise halt;
        }
    }

}