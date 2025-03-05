# There are few changes with respective to done in pom.xml like 
# ======================================================================
# <distributionManagement>
    <repository>
        <id>central</id>
        <name>ip-172-31-14-171-releases</name>
        <url>http://13.53.218.179:8081/artifactory/maven_test_jfrog </url>
    </repository>
    <snapshotRepository>
        <id>snapshots</id>
        <name>ip-172-31-14-171-snapshots</name>
        <url>http://13.53.218.179:8081/artifactory/maven_test_jfrog</url>
    </snapshotRepository>
</distributionManagement>
# ========================================================================================
# and if you are pushing from maven you need to add setting.xml in password ans username.
    <!-- Servers for repository authentication -->
  <servers>
    <!-- Credentials for the repository -->
    <server>
      <id>central</id> <!-- This ID should match the one in your pom.xml -->
      <username>admin</username>
      <password>password</password>
    </server>
  </servers>
# ===========================================================================================
mvn clean deploy    - This is used to deploy the code to jfrog. 
mvn clean install   - the is used to pull code from jfrog to local.
CLI : curl -u admin:password -O "http://13.53.218.179:8081/artifactory/maven_test_jfrog/com/test/HelloWorldMaven/1.1.1-RELEASE/HelloWorldMaven-1.1.1-RELEASE.jar"
# ====================================================================================================





