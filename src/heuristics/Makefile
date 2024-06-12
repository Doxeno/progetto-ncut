CPPFLAGS=-O3 -g -fsanitize=address

all: greedy bruteforce

greedy: greedy.cpp utils.hpp
	g++ $(CPPFLAGS) -o greedy greedy.cpp
bruteforce: bruteforce.cpp utils.hpp
	g++ $(CPPFLAGS) -o bruteforce bruteforce.cpp
