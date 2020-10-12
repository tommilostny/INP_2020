#Projekt INC 2020

Zadání **Vigenerova šifra** v souboru [projekt1_inp.pdf](https://github.com/tommilostny/INP_2020/blob/master/projekt1_inp.pdf).

##How to build for FITkit/ISIM

SVN checkout to FITkit repository

`svn checkout http://merlin.fit.vutbr.cz/svn/FITkit/trunk FITkit-svn`

---

Build/synthetize VHDL code

`fcmake`

`make`

---

Load to FITkit: `make load`

Start simulation: `make isim`

Clear build files: `make purge`

---

Other info at <https://merlin.fit.vutbr.cz/FITkit/docs/navody/qdevkitlinux.html>.

