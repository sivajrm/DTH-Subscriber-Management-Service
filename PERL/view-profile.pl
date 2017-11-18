#!C:\Perl\bin\perl.exe
print "Content-type:text/html;charset=iso-8859-1\n\n";
use CGI;
#use CGI::Carp qw(fatalsToBrowser);
$q=new CGI;
read(STDIN,$FormData,$ENV{'CONTENT-LENGTH'});
use Switch;

$name=$q->param('name');
$pass=$q->param('password');

#print $name;
#print $pass;
use DBI;

my $dbh = DBI->connect("DBI:ODBC:xxx") or die $DBI::errstr;
my $sth = $dbh->prepare("SELECT * FROM DATA");
$sth->execute() or die $DBI::errstr;
while (my @row = $sth->fetchrow_array()) {        
  if($name eq $row[0]){
  if($pass eq $row[1])
  {print "login successfull<BR>Hi $name";
   print "
   <html>
<head>
     <title>Profile page </title>
</head>
<body>
<a href=\"profile.pl?name=$row[2]&&region=$row[3]&&phone=$row[4]\">
Click here to Profile page
</a><br><br>
<a href=\"subs.pl?name=$row[2]&&bal=$row[5]&&pid=$row[6]&&from=$row[7]&&to=$row[8]\">
Click here for Subscription page
</a>
</body>  
 </html> ";}
  else 
  {print "not successfull";}
  }
}
$sth->finish();
$dbh->commit or die $DBI::errstr;