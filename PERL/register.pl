#!C:\Perl\bin\perl.exe
print "Content-type:text/html;charset=iso-8859-1\n\n";
use CGI;
use CGI::Carp qw(fatalsToBrowser);
$q=new CGI;
read(STDIN,$FormData,$ENV{'CONTENT-LENGTH'});
use Switch;

$name=$q->param('username');
$pass=$q->param('repassword');
$phone=$q->param('phone');
$region=$q->param('region');
$nname=$q->param('name');

use DBI;

my $dbh = DBI->connect("DBI:ODBC:xx") or die $DBI::errstr;
my $sth = $dbh->prepare("SELECT * FROM DATA WHERE USERNAME=?");

$sth->execute($name) or die $DBI::errstr;


while (my @row = $sth->fetchrow_array()) {
    print "$row[0] $row[1] $row[2] $row[3] $row[4]<br>";       
}
$sth->finish();
print "Inserted...";

 
my $sth = $dbh->prepare("INSERT INTO DATA(username,pass,name,region,phone,bal) values(?,?,?,?,?,?)");
$sth->execute($name,$pass,$nname,$region,$phone,100) or die $DBI::errstr;
$sth->finish();
$dbh->commit or die $DBI::errstr;