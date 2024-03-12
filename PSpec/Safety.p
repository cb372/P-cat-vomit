spec CatNeverVomitsOnCarpet observes eVomit {
    start state Init {
        on eVomit do {
            assert false, "Oh no, the cat vomited on the carpet!";
        }
    }
}