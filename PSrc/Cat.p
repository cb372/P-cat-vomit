event eVomit;
event eThanks;

machine Cat {

    start state EmptyStomach {
        on eFoodSmellsGood do (bowl: Bowl) {
            // eat the yummy food!

            // and say a polite "thank you" to the bowl
            send bowl, eThanks;

            goto FullStomach;
        }
    }

    state FullStomach {
        on eFoodSmellsGood do (bowl: Bowl) {
            // eat the yummy food!

            // ... and then vomit it all over the carpet :(
            announce eVomit;

            // and don't forget to say "thank you" to the bowl
            send bowl, eThanks;
        }
    }
}