spec CatGetsFed observes eThanks {
    start hot state Waiting {
        on eThanks do {
            goto CatWasFed;
        }
    }

    state CatWasFed {}
}