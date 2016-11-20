CXX = g++
#ifeq ($(__PERF), 1)
CXXFLAGS = -O0 -g -pg -pipe -fPIC -D__XDEBUG__ -W -Wwrite-strings -Wpointer-arith -Wreorder -Wswitch -Wsign-promo -Wredundant-decls -Wformat -Wall -D_GNU_SOURCE -D__STDC_FORMAT_MACROS -gdwarf-2 -Wno-unused-variable
#else
#	CXXFLAGS = -O2 -pipe -fPIC -W -Wwrite-strings -Wpointer-arith -Wreorder -Wswitch -Wsign-promo -Wredundant-decls -Wformat -Wall -D_GNU_SOURCE -D__STDC_FORMAT_MACROS -std=c++11 -gdwarf-2 -Wno-unused-variable
	# CXXFLAGS = -Wall -W -DDEBUG -g -O0 -D__XDEBUG__ 
#endif
OBJECT = mongosync
SRC_DIR = ./
OUTPUT = ./output

LIB_PATH = -L/home/wuxiaofei-xy/workplace/mongo-cxx-driver/build/install/lib/ \
					 -L/usr/local/lib/ \
					 -L/usr/lib64/

LIBS = -lmongoclient \
			 -lm \
			 -lpthread \
			 -lboost_regex-mt \
			 -lboost_thread-mt \
			 -lboost_system-mt \
			 -lrt \
			 -lssl \
			 -lcrypto \
			 -lsasl2

INCLUDE_PATH = -I/home/wuxiaofei-xy/workplace/mongo-cxx-driver/build/install/include/

.PHONY: all clean version


BASE_BOJS := $(wildcard $(SRC_DIR)/*.cc)
BASE_BOJS += $(wildcard $(SRC_DIR)/*.c)
BASE_BOJS += $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(patsubst %.cc,%.o,$(BASE_BOJS))

all: $(OBJECT)
	rm -rf $(OUTPUT)
	mkdir -p $(OUTPUT)
	mkdir -p $(OUTPUT)/bin
	mkdir -p $(OUTPUT)/log
	cp $(OBJECT) $(OUTPUT)/bin/
	rm -rf $(OBJECT)
	@echo "Success, go, go, go..."


mongosync: $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(INCLUDE_PATH) $(LIB_PATH) $(LIBS)

$(OBJS): %.o : %.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCLUDE_PATH) 

clean: 
	rm -rf $(OUTPUT)
	rm -rf $(SRC_DIR)/log
	rm -f $(SRC_DIR)/*.o
	rm -rf $(OBJECT)

