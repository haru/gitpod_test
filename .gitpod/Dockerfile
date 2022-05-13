FROM gitpod/workspace-full:latest

USER root
RUN git clone https://github.com/redmine/redmine.git -b 5.0-stable /workspace/redmine
RUN chown -R gitpod:gitpod /workspace/redmine

USER gitpod