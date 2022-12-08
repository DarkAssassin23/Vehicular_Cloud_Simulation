JAR = 'Vehicle_Cloud_Sim.jar'
JC = javac
MAIN = Main

# Source Dirs
SRC = src

JCFLAGS = -cp $(SRC) -d $(BINDIR)

#Class Files Directory
BINDIR = bin

#Log Files Directory
LOGDIR = log

#Source Files
SRCS = $(wildcard $(SRC)/*.java)

#Class Files
CLS = $(patsubst %.java, $(BINDIR)/%.class, $(SRCS))

default: jar
all: jar

$(CLS): $(BINDIR)/%.class: %.java
ifeq ($(OS),Windows_NT)
	@if not exist $(@D) @mkdir $(@D)
else
	@mkdir -p $(@D)
endif
	$(JC) $(JCFLAGS) $<
	
jar: $(CLS)
	jar cfe $(JAR) $(MAIN) -C $(BINDIR) .
	
clean:
ifeq ($(OS),Windows_NT)
	-rmdir $(BINDIR) /q /s 2>nul && rmdir $(LOGDIR) /q /s 2>nul && del $(JAR) /q /f 2>nul
else
	-rm -rf $(BINDIR) $(LOGDIR) $(JAR)
endif
