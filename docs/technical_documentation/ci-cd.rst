 .. _ ci-cd:

Continuous Integration and Delivery
=================================================

.. toctree::

.. uml:: pipeline/pipeline.puml


GitLab Pipeline
----------------

The arcadia team is using a dockerbased GitLab-Runner pipeline for continuous integration and deployment. The pipeline
currently consists of two stages: test and deploy. The test stage is always executed, the deploy stage is only executed
if the pipeline job runs on the main branch. Doing so, the main branch is also the production branch. Every merge
on the main branch is automatically deployed to the production system.

Junit test results from Node.js
-------------------------------

GitLab Pipeline can only analyze test results in junit-xml format, arcadia uses Node.js as a base backend and frontend
language. To output a test result in a GitLab-Pipeline-understandable format, jest-junit is used. In the package.json
is a special script "test:ci" to execute Node.js tests with the junit reporter. To merge a branch into the main-branch
it's necessary to execute all tests successfully - if not, the merge is prohibited.

Deployment with ansible playbook
--------------------------------

To deploy the newly create docker images on the production system, an ansible playbook, located in the ansible folder, is
used. After successfully building all docker images, the images are published to docker-hub, after that, the ansible
playbook is started in the pipeline. The production system is fetching the newly published image and the production is
getting ready.


Gitlab Runner
-------------

To execute GitLab Pipelines a GitLab Runner is needed. The Gitlab Runner is hosted on our private hardware. The Runner
is a docker image. On job run, new docker containers are created to execute the test and the deploy steps.
