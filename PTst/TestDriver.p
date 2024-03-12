
/*
 * If there's only one human, we don't need a whiteboard.
 * The human will fill the bowl exactly once,
 * so the cat will be fed (liveness)
 * and the cat will not vomit on the carpet (safety).
 */
machine OneHumanNoWhiteboard { 
    var kiki: Cat;
    var bowl: Bowl;
    var whiteboard: Whiteboard;
    var chris: Hooman;

    start state Init {
        entry {
            kiki = new Cat();
            bowl = new Bowl(kiki);
            whiteboard = new Whiteboard();
            chris = new Hooman((b = bowl, w = whiteboard, useWhiteboard = false));
        }
    }
}

/*
 * But if we have two humans, and they don't communicate with each other using a whiteboard,
 * there is a risk of the cat being fed twice and vomiting on the carpet.
 * So the safety spec fails for this test.
 */
machine TwoHumansNoWhiteboard { 
    var kiki: Cat;
    var bowl: Bowl;
    var whiteboard: Whiteboard;
    var chris: Hooman;
    var yoshiko: Hooman;

    start state Init {
        entry {
            kiki = new Cat();
            bowl = new Bowl(kiki);
            whiteboard = new Whiteboard();
            chris = new Hooman((b = bowl, w = whiteboard, useWhiteboard = false));
            yoshiko = new Hooman((b = bowl, w = whiteboard, useWhiteboard = false));
        }
    }
}

/*
 * If the humans use a whiteboard for coordination, all is good again.
 * One human will put a tick on the whiteboard and then fill the bowl exactly once.
 * The other human will do nothing, because the whiteboard is already ticked.
 *
 * We assume the act of inspecting the whiteboard and drawing a tick on it
 * (if it's not already ticked) is atomic.
 */
machine TwoHumansUsingWhiteboard { 
    var kiki: Cat;
    var bowl: Bowl;
    var whiteboard: Whiteboard;
    var chris: Hooman;
    var yoshiko: Hooman;

    start state Init {
        entry {
            kiki = new Cat();
            bowl = new Bowl(kiki);
            whiteboard = new Whiteboard();
            chris = new Hooman((b = bowl, w = whiteboard, useWhiteboard = true));
            yoshiko = new Hooman((b = bowl, w = whiteboard, useWhiteboard = true));
        }
    }
}

/*
 * However, if one human ticks the whiteboard but then gets distracted and wanders off
 * without filling the bowl, we have a liveness issue. Literally - if this happens enough times,
 * the cat will starve!
 */
machine TwoHumansUsingWhiteboardWithOneFailure { 
    var kiki: Cat;
    var bowl: Bowl;
    var whiteboard: Whiteboard;
    var chris: Hooman;
    var yoshiko: Hooman;
    var hoomans: set[machine];

    start state Init {
        entry {
            kiki = new Cat();
            bowl = new Bowl(kiki);
            whiteboard = new Whiteboard();
            
            chris = new Hooman((b = bowl, w = whiteboard, useWhiteboard = true));
            yoshiko = new Hooman((b = bowl, w = whiteboard, useWhiteboard = true));
            hoomans += (chris);
            hoomans += (yoshiko);

            /*
             * Add a failure injector to make one of the humans suddenly drop dead!
             * Or, less dramatically, get distracted and wander off somewhere.
             */
            CreateFailureInjector((nodes = hoomans, nFailures = 1));
        }
    }
}