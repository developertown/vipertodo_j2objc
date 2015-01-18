.SUFFIXES: .java .m

BUILD_DIR = build
SOURCE_DIR = ./src
APP_DIR = $(SOURCE_DIR)/main/java
TEST_DIR = $(SOURCE_DIR)/test/java

# Change to where distribution was unzipped.
J2OBJC_DISTRIBUTION = $(HOME)/Developer/j2objc
J2OBJC = $(J2OBJC_DISTRIBUTION)/j2objc
J2OBJCC = $(J2OBJC_DISTRIBUTION)/j2objcc

JUNIT = $(J2OBJC_DISTRIBUTION)/lib/junit-4.10.jar
MOCKITO = $(J2OBJC_DISTRIBUTION)/lib/mockito-core-1.9.5.jar


APP_JAVA_SOURCES = $(shell find $(APP_DIR) -type f -name '*.java')
APP_OBJECTS = $(patsubst $(APP_DIR)/%.java, $(BUILD_DIR)/%.o, $(APP_JAVA_SOURCES))
APP_OBJS_SOURCES = $(OBJECTS:.o=.m)

TEST_JAVA_SOURCES = $(shell find $(TEST_DIR) -type f -name '*.java')
TEST_OBJECTS = $(patsubst $(TEST_DIR)/%.java, $(BUILD_DIR)/%.o, $(TEST_JAVA_SOURCES))
TEST_OBJS_SOURCES = $(OBJECTS:.o=.m)
TEST_RESULT = $(BUILD_DIR)/app_tests


default: translate $(APP_OBJECTS)

test: default $(TEST_RESULT)
	$(TEST_RESULT) org.junit.runner.JUnitCore com.jonnolen.viperj2objc.test.AllTests

$(TEST_RESULT): translate_tests $(TEST_OBJECTS)
	$(J2OBJCC) -o $@ -ObjC -ljunit -lmockito $(APP_OBJECTS) $(TEST_OBJECTS)

#app_tests: translate_tests $(TEST_OBJECTS)

clean:
	@rm -rf $(BUILD_DIR)

translate:
	$(J2OBJC) -sourcepath $(APP_DIR) -d $(BUILD_DIR) $(APP_JAVA_SOURCES)

translate_tests:
	$(J2OBJC) -sourcepath $(TEST_DIR) -cp $(APP_DIR) -cp $(JUNIT) -cp $(MOCKITO) -d $(BUILD_DIR) $(TEST_JAVA_SOURCES)



$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.m
	$(J2OBJCC) -I$(BUILD_DIR) -c $? -o $@

$(BUILD_DIR):
	@mkdir $(BUILD_DIR)