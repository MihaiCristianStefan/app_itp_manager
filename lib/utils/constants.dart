final String smsMessage =
    "Buna ziua! Va informam ca in data de {DATE} va expira ITP-ul la auto cu nr. {CARPLATES}. Documente necesare: cartea de identitate a autovehiculului, talonul si buletinul persoanei care se prezinta la ITP. Nu este necesara programarea in prealabil.Va asteptam la sediul firmei noastre din Com. Albota, str. Ecologiei nr. 793D (vis-a-vis de Cipcos Mar). Echipa Vector Truck Management. Informatii la 0769608463";

final String customersTable =
    "CREATE TABLE customers(id INTEGER PRIMARY KEY, name TEXT, carPlates TEXT, phone TEXT, lastITP TEXT, nextITP TEXT, receivedSms INTEGER);";
