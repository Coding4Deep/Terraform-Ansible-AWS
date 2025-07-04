# Project Challenges & Issues Summary

---

## 1. Nexus and Maven Integration Security Concerns

**Context:**  
Maven configuration requires Nexus repository URLs and credentials.

**Issues:**  
- Credentials (username/password) hardcoded directly in Maven’s `settings.xml` or `pom.xml`, which is insecure especially in shared or CI environments.  
- URL of Nexus repositories also hardcoded in project files, risking exposure if stored in GitHub or other VCS.

**Impact:** Security risk of credential leaks and inflexible configuration.

---

## 2. Passing Nexus Credentials Securely in Jenkins Pipelines

**Context:**  
Integrating Maven deploy in Jenkins pipeline while keeping Nexus credentials secure.

**Issues:**  
- Maven deploy fails with 401 Unauthorized when credentials not passed correctly.  
- Uncertainty whether credentials should go into `settings.xml`, command line parameters, or environment variables.  
- Difficulty in passing credentials securely via Jenkins `withCredentials` block and Maven command.  
- Conflicts or confusion when using Jenkins Maven plugin and manual Maven commands.

**Impact:** Build and deploy stages fail; insecure handling of secrets.

---

## 3. SonarQube Integration with Jenkins and Maven

**Context:**  
Adding static code analysis with SonarQube into the pipeline.

**Issues:**  
- Deciding whether to use Jenkins SonarQube plugin or standalone Sonar Scanner CLI.  
- Wanting test results and coverage reports visible in Jenkins UI, but Maven project does not generate Surefire reports due to lack of tests.  
- Jacoco coverage only generates reports when tests are present.  
- Correct ordering of build and SonarQube analysis stages in pipeline.

**Impact:** Incomplete visibility of code quality metrics; pipeline misconfiguration.

---

## 4. Deploying WAR to Tomcat on a Different EC2 Instance

**Context:**  
Jenkins runs on one server; Tomcat runs on another EC2 instance (frontend server).

**Issues:**  
- Manual SSH needed initially for deployment, not automated.  
- How to automate SSH connections and SCP file transfers securely within Jenkins pipeline.  
- Managing separate Jenkinsfiles for Terraform infra, Ansible setup, and app deployment complicates full automation.

**Impact:** Deployment is semi-manual, slowing delivery and increasing error risk.

---

## 5. Permission Denied on SCP to Tomcat `webapps` Directory

**Context:**  
Attempt to copy WAR file from Jenkins to Tomcat’s deployment directory via SCP.

**Issues:**  
- `scp` fails with permission denied because the Jenkins user (`ubuntu`) lacks write access to `/opt/tomcat/webapps/` owned by `tomcat` user/group.  
- Lack of appropriate group membership or permissions on deployment directories.

**Impact:** Deployment fails due to file permission errors.

---


