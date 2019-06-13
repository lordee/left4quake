all:
	#fteqcc64 ./csqc/progs.src
	fteqcc64 ./ssqc/progs.src
	#cp ./csprogs.dat /home/danni/Games/quake-team-fortress-server/overquake/csprogs.dat
	cp ./qwprogs.dat /home/danni/Games/quake-team-fortress-server/left4quake/qwprogs.dat

clean:
	rm -f $(TARGET) qwprogs.lno files.dat progdefs.h
