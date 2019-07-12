all:
	fteqcc64 ./csqc/progs.src
	fteqcc64 ./ssqc/progs.src
	cp ./csprogs.dat /home/danni/Games/quake-team-fortress-server/left4quake/csprogs.dat
	cp ./qwprogs.dat /home/danni/Games/quake-team-fortress-server/left4quake/qwprogs.dat
	cp -r ./scripts /home/danni/Games/quake-team-fortress-server/left4quake
	cp -r ./scripts /home/danni/Games/Quake/left4quake
	cp -r ./glsl /home/danni/Games/quake-team-fortress-server/left4quake
	cp -r ./glsl /home/danni/Games/Quake/left4quake
clean:
	rm -f $(TARGET) qwprogs.lno files.dat progdefs.h
