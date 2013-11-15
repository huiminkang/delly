BOOST=/g/solexa/bin/software/boost_1_53_0
BAMTOOLS=/g/solexa/bin/software/bamtools/
KSEQ=/g/solexa/bin/software/kseq/

CXX=g++
CXXFLAGS += -isystem ${BOOST}/include -isystem ${BAMTOOLS}/include -isystem ${KSEQ}
CXXFLAGS += -O9 -pedantic -W -Wall

### Valgrind
## Debugging, turn --static off so valgrind can surpress glibc errors
#CXXFLAGS += -g -O0 -fno-inline -pedantic -W -Wall
##Set the library path: export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${BOOST}/lib:${BAMTOOLS}/lib
## Run valgrind (1): valgrind --leak-check=yes --track-origins=yes --num-callers=30 --error-limit=no --track-fds=yes ...
## Run valgrind (2): valgrind --tool=massif ...
### Cppcheck
## cppcheck -I${BAMTOOLS}/include -I${KSEQ} -I${BOOST}/include/ --enable=style,performance,portability,information,unusedFunction delly/delly.cpp

LDFLAGS += -L${BOOST}/lib -lboost_iostreams -lboost_filesystem -lboost_system -lboost_program_options -lboost_date_time -L${BAMTOOLS}/lib -lbamtools -lz
LDFLAGS += --static

TARGETS = delly iover cov spancov iMerge extract 

all:   	$(TARGETS)

delly:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

iover:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

iMerge:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

extract:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

cov:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

spancov:
	$(CXX) $(CXXFLAGS) $@.cpp -o $@ $(LDFLAGS)

clean:
	rm -f $(TARGETS) $(TARGETS:=.o)