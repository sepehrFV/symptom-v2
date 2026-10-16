package msfv.original;

import java.util.concurrent.ThreadLocalRandom;

public class $ {

    public static int randomBetween(int min, int max) {
        if (min > max) {
            throw new IllegalArgumentException("min must be <= max");
        }
        return ThreadLocalRandom.current().nextInt(min, max + 1);
    }

}
