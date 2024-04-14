#!/usr/bin/perl

$diretorio="/usr/coleta_crc/log_interfaces";
use Shell;

# abro o diretório
opendir (MEUDIR, "$diretorio");
@pegoodir = readdir(MEUDIR);
closedir (MEUDIR);

my $sh = Shell->new;

   foreach (@pegoodir) {

      $dados = $_; # como só existe uma coluna no vetor, utilizei o $_ para pegar esta coluna.
      if ($dados eq '.'){next}
      if ($dados eq '..'){next}
      open (log_rtt,"$diretorio/$dados");
      @info_a=lstat(log_rtt);

      close(log_rtt);

      $t=time();

      $ta=@info_a[9];

      $dif=$t-$ta;

      if ($dif>3599){

          print "$dados | $t | $ta |--- $dif \n";
          $sh->rm("$diretorio/$dados");

      }
   }


exit
