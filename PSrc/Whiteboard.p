event eWhiteboardWasAlreadyTicked: bool;

machine Whiteboard {

    start state Unticked {
        on eTickWhiteboardIfNotAlreadyTicked do (hooman: Hooman) {
            send hooman, eWhiteboardWasAlreadyTicked, false;
            goto Ticked;
        }
    }

    state Ticked {
        on eTickWhiteboardIfNotAlreadyTicked do (hooman: Hooman) {
            send hooman, eWhiteboardWasAlreadyTicked, true;
        }
    }
}