# Um parser em bash que identifica enums de um fonte Java

Era uma vez, um código Java, uma enumeração inocente. Ele funcionava
em Java Web, e GWT, e se viu que ele era bom.

Então, a direção da empresa resolveu fazer a versão mobile em Flutter
e essa enumeração precisava existir em código Dart também. E se viu
que isso era ruim.

Das estratégias possíveis para evitar deriva de código, foi escolhida
a de checar (em tempo de CI, com scripts passíveis de rodar manualmente)
se as enumerações estavam condizentes.

Esta é a minha jornada para fazer o identificador de enumerações em Java
e verificar se estava coerente com o que existia em Dart.

Esta é a versão de apresentação [deste meu
artigo](https://computaria.gitlab.io/blog/2022/03/20/bash-java-enum-parser),
com direito a expansão em como foi feita a checagem de subconjunto

# How to Run

- clone the repo
- install the dependencies `yarn`
- run `yarn start`
- open `http://localhost:8080` and see the slides

# Caveats

The `pdf` does not perfectly works with code surfer, be aware.

To build locally, you need to run `yarn postinstall` before `yarn build`. This
is not necessary for running the repo.