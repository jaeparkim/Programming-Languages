
Use addressbook example as follows:

1. Compile the code:

% salsac addressbook/*

2. In a separate terminal, run the name server:

% wwcns

3. In a separate terminal, run the address book service:

% salsa -Duan=uan://localhost:3030/ab addressbook.AddressBook

4. Run an address book client to add a user:

% salsa addressbook.AddUser uan://localhost:3030/ab foo "foo@bar.org"

5.  Run an address book client to get a user's email:

% salsa addressbook.GetEmail uan://localhost:3030/ab foo 
foo's email: foo@bar.org


