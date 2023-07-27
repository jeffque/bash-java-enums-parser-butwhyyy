package com.github.jeffque;

public enum Day {
    SUNDAY, MONDAY, TUESDAY, WEDNESDAY,
    THURSDAY, FRIDAY, SATURDAY;

    private final int weekday;
    Day() {
        weekday = -1;
    }
    Day(int weekday) {
        this.weekday = weekday;
    }
}
