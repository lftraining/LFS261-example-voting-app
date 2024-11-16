Sat Nov 16 09:46:06 EST 2024

http://34.48.26.32:8080/job/instavote/job/worker-pipe/job/master/3/console
    ```
    Started by user admin
    15:07:59 Connecting to https://api.github.com using chilikm4n/******
    Obtained worker/Jenkinsfile from f85634240458a7a200a702176755ee2149e35bd8
    org.codehaus.groovy.control.MultipleCompilationErrorsException: startup failed:
    WorkflowScript: 3: Invalid agent type "docker" specified. Must be one of [any, label, none] @ line 3, column 8.
              docker{ 
              ^
    
    1 error
    
    	at org.codehaus.groovy.control.ErrorCollector.failIfErrors(ErrorCollector.java:309)
    	at org.codehaus.groovy.control.CompilationUnit.applyToPrimaryClassNodes(CompilationUnit.java:1107)
    	at org.codehaus.groovy.control.CompilationUnit.doPhaseOperation(CompilationUnit.java:624)
    	at org.codehaus.groovy.control.CompilationUnit.processPhaseOperations(CompilationUnit.java:602)
    	at org.codehaus.groovy.control.CompilationUnit.compile(CompilationUnit.java:579)
    	at groovy.lang.GroovyClassLoader.doParseClass(GroovyClassLoader.java:323)
    	at groovy.lang.GroovyClassLoader.parseClass(GroovyClassLoader.java:293)
    	at org.jenkinsci.plugins.scriptsecurity.sandbox.groovy.GroovySandbox$Scope.parse(GroovySandbox.java:163)
    	at org.jenkinsci.plugins.workflow.cps.CpsGroovyShell.doParse(CpsGroovyShell.java:190)
    	at org.jenkinsci.plugins.workflow.cps.CpsGroovyShell.reparse(CpsGroovyShell.java:175)
    	at org.jenkinsci.plugins.workflow.cps.CpsFlowExecution.parseScript(CpsFlowExecution.java:652)
    	at org.jenkinsci.plugins.workflow.cps.CpsFlowExecution.start(CpsFlowExecution.java:598)
    	at org.jenkinsci.plugins.workflow.job.WorkflowRun.run(WorkflowRun.java:335)
    	at hudson.model.ResourceController.execute(ResourceController.java:101)
    	at hudson.model.Executor.run(Executor.java:442)
    
    GitHub has been notified of this commit’s build result
    
    Finished: FAILURE
      
    ```
**POTENTIAL SOLUTIONS**:
https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/Fix-Jenkins-Invalid-agent-type-Docker-specified-any-label-none-error
  - **MAIN POINTS**: missing...
    - Jenkins Docker Plugin 
    - Jenkins Docker Pipeline plugini
    + **INSTALLED**
      - [x] Docker Pipeline 580.vc0c340686b_54
      - [x] Docker plugin 1.6.2
    + [ ] resolves issue?
      + [x] feature/workpipe builds (#14)
      - [ ] master: fail [x] attempt: (#4)
    + [?] `Jenkinsfile` "Maven" => "maven"
      - [x] attempted fail (#5)
      - [x] check: `docker inspect -f . maven:3.9.8-sapmachine-21`
      - [x] they both failed (#16/17) complaining about "Maven"
    - [ ] attempt update master
     
        ```
        avirtualrealitystory@ci-4nov24:~/06/lfx261/15Nov24a$ sudo docker inspect -f . mav
        en:3.9.8-sapmachine-21
        Error: No such object: maven:3.9.8-sapmachine-21
        
        ```
____

          ```
          Started by user admin
          15:21:52 Connecting to https://api.github.com using chilikm4n/******
          Obtained worker/Jenkinsfile from f85634240458a7a200a702176755ee2149e35bd8
          [Pipeline] Start of Pipeline
          [Pipeline] node
          Running on Jenkins in /var/jenkins_home/workspace/instavote_worker-pipe_master
          [Pipeline] {
          [Pipeline] stage
          [Pipeline] { (Declarative: Checkout SCM)
          [Pipeline] checkout
          The recommended git tool is: NONE
          using credential 7447b235-b3ee-4c12-b034-b133cb332a41
          Cloning the remote Git repository
          Cloning with configured refspecs honoured and without tags
          Cloning repository https://github.com/chilikm4n/LFS261-example-voting-app.git
           > git init /var/jenkins_home/workspace/instavote_worker-pipe_master # timeout=10
          Fetching upstream changes from https://github.com/chilikm4n/LFS261-example-voting-app.git
           > git --version # timeout=10
           > git --version # 'git version 2.39.2'
          using GIT_ASKPASS to set credentials 
           > git fetch --no-tags --force --progress -- https://github.com/chilikm4n/LFS261-example-voting-app.git +refs/heads/master:refs/remotes/origin/master # timeout=10
           > git config remote.origin.url https://github.com/chilikm4n/LFS261-example-voting-app.git # timeout=10
           > git config --add remote.origin.fetch +refs/heads/master:refs/remotes/origin/master # timeout=10
          Avoid second fetch
          Checking out Revision f85634240458a7a200a702176755ee2149e35bd8 (master)
           > git config core.sparsecheckout # timeout=10
           > git checkout -f f85634240458a7a200a702176755ee2149e35bd8 # timeout=10
          Commit message: "Merge pull request #1 from chilikm4n/readme"
          First time build. Skipping changelog.
          [Pipeline] }
          [Pipeline] // stage
          [Pipeline] withEnv
          [Pipeline] {
          [Pipeline] isUnix
          [Pipeline] withEnv
          [Pipeline] {
          [Pipeline] sh
          + docker inspect -f . maven:3.9.8-sapmachine-21
          
          error during connect: Get "https://docker:2376/v1.47/containers/maven:3.9.8-sapmachine-21/json": dial tcp: lookup docker on 127.0.0.11:53: server misbehaving
          [Pipeline] isUnix
          [Pipeline] withEnv
          [Pipeline] {
          [Pipeline] sh
          + docker pull maven:3.9.8-sapmachine-21
          error during connect: Post "https://docker:2376/v1.47/images/create?fromImage=maven&tag=3.9.8-sapmachine-21": dial tcp: lookup docker on 127.0.0.11:53: server misbehaving
          [Pipeline] }
          [Pipeline] // withEnv
          [Pipeline] }
          [Pipeline] // withEnv
          [Pipeline] }
          [Pipeline] // withEnv
          [Pipeline] }
          [Pipeline] // node
          [Pipeline] stage
          [Pipeline] { (Declarative: Post Actions)
          [Pipeline] echo
          the job is complete
          [Pipeline] }
          [Pipeline] // stage
          [Pipeline] End of Pipeline
          ERROR: script returned exit code 1
          
          GitHub has been notified of this commit’s build result
          
          Finished: FAILURE
            
          ```


____
+ [x] determine where to revert back to
  - lab7-1:p10
+ [x] create repair branch
+ [x] git directory to push: this directory
  - contains commits from the lab
  - the only main differences between each directories were the:
    - Jenkinsfile(s)
    - README.md 
    - All other files were alike
*to the best of my knowledge*
+ [x] Jenkins setup already done
+ [x] git setup already done
