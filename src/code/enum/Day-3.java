// comentário de linha

/* e o
  de bloco */
package com.github.jeffque;

// comentário de linha {

/* e o
  de bloco{ */

  public enum Day {
    SUNDAY /* um bloco *no meio */, MONDAY, TUESDAY, WEDNESDAY,
    // quebrando a linha} */;
    THURSDAY, FRIDAY, SATURDAY;

    // oops quebrando a linha
    private final int weekday;
    Day() {
        weekday = -1;
    }
    Day(int weekday) {
        this.weekday = weekday;
    }
    /* passando aqui
       com o meu bloco */
}
