.SUFFIXES: .java .m

BUILD_DIR = build
SOURCE_DIR = ./src
APP_DIR = $(SOURCE_DIR)/main/java
#TEST_DIR = $(SOURCE_DIR)/test/java

# Change to where distribution was unzipped.
J2OBJC_DISTRIBUTION = $(HOME)/Developer/j2objc
J2OBJC = $(J2OBJC_DISTRIBUTION)/j2objc
J2OBJCC = $(J2OBJC_DISTRIBUTION)/j2objcc

JUNIT = $(J2OBJC_DISTRIBUTION)/lib/junit-4.10.jar
MOCKITO = $(J2OBJC_DISTRIBUTION)/lib/mockito-core-1.9.5.jar


JAVA_SOURCES = $(shell find $(APP_DIR) -type f -name '*.java')
OBJECTS = $(patsubst $(APP_DIR)/%.java, $(BUILD_DIR)/%.o, $(JAVA_SOURCES))
OBJS_SOURCES = $(OBJECTS:.o=.m)

default: translate $(OBJECTS)

clean:
	@rm -rf $(BUILD_DIR)

translate:
	$(J2OBJC) -sourcepath $(APP_DIR) -d $(BUILD_DIR) $(JAVA_SOURCES)

$(BUILD_DIR)/%.o: $(BUILD_DIR)/%.m
	$(J2OBJCC) -I$(BUILD_DIR) -c $? -o $@

$(BUILD_DIR):
	@mkdir $(BUILD_DIR)