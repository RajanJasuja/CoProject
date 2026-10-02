trigger forUpdateTest on Contact (before Update) {



Account a =[Select name from Account where name='GenePoint' for Update];
Account a1 =[Select name from Account where name='GenePoint' for Update];
update a1;

}