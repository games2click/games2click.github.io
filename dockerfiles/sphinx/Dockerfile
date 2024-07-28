FROM minidocks/sphinx-doc:5

RUN pip install sphinxcontrib-plantuml watchfiles
RUN apk add openjdk11 ttf-dejavu graphviz

ADD https://github.com/plantuml/plantuml/releases/download/v1.2023.12/plantuml-1.2023.12.jar /opt/plantuml/plantuml.jar
