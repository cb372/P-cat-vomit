event eFoodSmellsGood: Bowl;

machine Bowl {
    var cat: Cat;

    start state Init {
        entry(c: Cat) {
            cat = c;
            goto Empty;
        }
    }

    state Empty {
        on eFillBowl do {
            send cat, eFoodSmellsGood, this;
            goto Full;
        }
    }

    state Full {
        on eFillBowl do {
            // Ignore any attempts to fill the bowl if it is already full
            // (we assume the hoomans are smart enough not to do that)
        }

        on eThanks do {
            // you're welcome!
            goto Empty;
        }
    }
}