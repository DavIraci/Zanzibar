-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: iraci
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `name` varchar(120) NOT NULL,
  `quantity` int NOT NULL DEFAULT '-1',
  `description` varchar(300) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `barcode` varchar(12) NOT NULL,
  `category` varchar(45) NOT NULL,
  PRIMARY KEY (`barcode`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('Croissant vari gusti',-1,'pan brioche, confettura di albicocca o crema pasticciera o crema al pistacchio o crema alle nocciole.',1.20,'1','Colazione'),('Calzone al cotto',-1,'mozzarella, calzone, olio di semi di girasole, prosciutto cotto.',2.50,'10','Rustici'),('BST',-1,'cabernet merlot IGT folonari.',20.00,'100','Vini Rossi'),('Vodka Belvedere',-1,'vodka.',7.00,'101','Distillati'),('Vodka Beluga',-1,'vodka.',7.00,'102','Distillati'),('Gentleman Jack',-1,'whisky.',7.00,'103','Distillati'),('Woodford Reserve',-1,'whisky.',7.00,'104','Distillati'),('Jack Daniel\'s Barrel',-1,'whiskey.',7.00,'105','Distillati'),('Lagavulin 16',-1,'whisky.',7.00,'106','Distillati'),('Oban 14',-1,'whisky.',7.00,'107','Distillati'),('Talisker 14',-1,'whisky.',7.00,'108','Distillati'),('Appleton Vx',-1,'rum.',7.00,'109','Distillati'),('Focaccia vari gusti',-1,'focaccia, acciughe sott\'olio, indivia, melanzane, olio di semi di girasole, parmigiano reggiano DOP, provola, salsa di pomodoro, ricotta di pecora.',2.00,'11','Rustici'),('Don Papa Rum',-1,'rum.',7.00,'110','Distillati'),('Gin Malfy',-1,'gin.',7.00,'111','Distillati'),('Gin London',-1,'gin.',7.00,'112','Distillati'),('Gin Mare',-1,'gin.',7.00,'113','Distillati'),('Gin Hendrick\'s',-1,'gin.',7.00,'114','Distillati'),('Acqua 50cl',-1,'acqua.',1.00,'115','Analcolici'),('Lemon soda 33cl',-1,'soda al limone.',2.50,'116','Analcolici'),('Chinotto 33cl',-1,'chinotto.',2.50,'117','Analcolici'),('Fanta 33cl',-1,'aranciata.',2.50,'118','Analcolici'),('Sprite 33cl',-1,'soda.',2.50,'119','Analcolici'),('Spicchi di patate dorate',-1,'patate, olio di semi di girasole, sale.',3.00,'12','Rustici'),('Coca Cola 33cl',-1,'soda.',2.50,'120','Analcolici'),('Succhi di frutta 33cl',-1,'succo di frutta.',2.50,'121','Analcolici'),('Red Bull 33cl',-1,'energy drink.',3.50,'122','Analcolici'),('Crodino 33cl',-1,'crodino',2.50,'123','Analcolici'),('Bitter bianco/rosso 33cl',-1,'bitter.',2.50,'124','Analcolici'),('Calzone messinese',-1,'mozzarella, calzone, acciughe sott\'olio, indivia, pomodorini, olio di semi di girasole.',2.50,'13','Rustici'),('Mista',-1,'carote, lattuga, pomodoro cuore di bue, radicchio rosso.',4.00,'14','Insalatone'),('Estiva',-1,'lattuga, mozzarella, olio extra vergine di oliva, pomodoro cuore di bue, uova di gallina.',6.00,'15','Insalatone'),('Salina',-1,'lattuga, mais, olio extra vergine di oliva, olio di semi di girasole, pomodorini datterini, tonno in salamoia sgocciolato.',6.00,'16','Insalatone'),('Norvegese',-1,'lattuga, olio extra vergine di oliva, olive nere, radicchio rosso, salmone affumicato.',7.00,'17','Insalatone'),('Mediterranea',-1,'mozzarella, olio extra vergine di oliva, olive nere, pomodoro cuore di bue, radicchio rosso.',5.00,'18','Insalatone'),('I semifreddi',-1,'frutta a guscio (allergene), semifreddo, biscotto, fave di cacao, pan di spagna.',4.00,'19','Frutta e Dessert'),('Caprese',-1,'pomodoro, mozzarella, olio extra vergine di oliva, basilico, origano, pane a lievitazione naturale.',4.00,'2','Panini'),('Tartufo gelato',-1,'tartufo bianco, tartufo nero, gelato, caffé.',2.50,'20','Frutta e Dessert'),('Brioche siciliana',-1,'pan brioche.',0.80,'21','Frutta e Dessert'),('Granita vari gusti',-1,'ghiaccio, cacao, chicci di caffé, destrosio, fragole, frutta a guscio (allergene), frutti di bosco, limone, melone d\'estate, panna montata, pesca, zucchero.',1.80,'22','Frutta e Dessert'),('Frutta fresca di stagione',-1,'ananas, pere, melone, mela, uva, fragole, melone d\'estate, pesca.',5.00,'23','Frutta e Dessert'),('Gran coppa gelato belvedere',-1,'gelato, biscotto, cioccolato, frutta a guscio (allergene), panna montata.',6.00,'24','Frutta e Dessert'),('Sfizi fritti di mare el giorno',-1,'olio extra vergine di oliva, semola di grano duro, farina di grano tenero, sale, variabile, olio di arachidi.',10.00,'25','Antipasti Di Mare'),('Degustazione di antipasti belvedere',-1,'racchiude tutti glli antipasti sopra elencati più degli assaggini del giorno che possono essere proposti dal cameriere.',20.00,'26','Antipasti Di Mare'),('Insalata di mare al vapore ai profumi mediterranei',-1,'aglio, olio extra vergine di oliva, vongole, calamari, cozze, prezzemolo, gamberi, limone, polpo.',12.00,'27','Antipasti Di Mare'),('Crudo di gamberi di mazzara, salsa di soia e frutta fresca di stagione',-1,'olio extra vergine di oliva, soia, ananas, pere, melone, mela, uva, gamberi, sale, salsa di soia.',14.00,'28','Antipasti Di Mare'),('Crudo di parma e mozzarella di bufala campana',-1,'prosciutto crudo, mozzarella di bufala.',10.00,'29','Antipasti Di Terra'),('Toast',-1,'pancarré, prosciutto cotto, sottilette.',2.00,'3','Panini'),('Misto di salumi, formaggi, confetture e conserve del territorio',-1,'pomodoro, formaggio stagionato, carne di maiale, olive verdi, olive nere, salame di maiale, prosciutto crudo, ricotta, pancetta, provola, pomodori secchi.',14.00,'30','Antipasti Di Terra'),('Busiate alla belvedere',-1,'olio extra vergine di oliva, basilico, farina di grano tenero, sale, olio di semi di girasole, capperi, semi di girasole, melanzane, mentuccia, uva passa, pesce spada, pinoli, pomodorini, pasta fresca all\'uovo.',12.00,'31','Primi Di Mare'),('Scialatielli all\'astice',-1,'pomodoro, aglio, olio extra vergine di oliva, astice, prezzemolo, olio di oliva, pasta fresca all\'uovo.',18.00,'32','Primi Di Mare'),('Couscous di pesce, crostacei e verdure',-1,'pomodoro, aglio, olio extra vergine di oliva, vongole, basilico, semola di grano duro, calamari, cous cous, cozze, gamberi, carote, melanzane, peperoni, zucchine, pesce (allergene).',14.00,'33','Primi Di Mare'),('Risotto mantecato al modo del pescatore',-1,'pomodoro, aglio, olio extra vergine di oliva, riso bianco, vongole, calamari, cozze, prezzemolo, gamberi.',12.00,'34','Primi Di Mare'),('Linguine trafilate al bronzo allo scoglio',-1,'pomodoro, pasta, aglio, olio extra vergine di oliva, cannolicchio, vongole, semola di grano duro, calamari, totani, cozze, prezzemolo, fasolari, grano, gamberi, scampi.',16.00,'35','Primi Di Mare'),('Spaghettoni alla chitarra, vongole veraci e bottarga',-1,'pasta, aglio, olio extra vergine di oliva, vongole, semola di grano duro, prezzemolo, uova di pesce spada.',14.00,'36','Primi Di Mare'),('Gnocchi alla sorrentina',-1,'pomodoro, olio extra vergine di oliva, uova di gallina, basilico, mozzarella, gnocchi di patate.',10.00,'37','Primi Di Terra'),('Maccheroni tipici alla norma',-1,'pomodoro, olio extra vergine di oliva, basilico, sale, olio di semi di girasole, semi di girasole, ricotta, melanzane, pasta fresca all\'uovo.',10.00,'38','Primi Di Terra'),('Bavette integrali al pesto di pistacchi di bronte',-1,'aglio, olio extra vergine di oliva, basilico, parmigiano reggiano DOP, pistacchi, pasta integrale.',10.00,'39','Primi Di Terra'),('Hot dog',-1,'wurstel di maiale, pane al latte, ketchup, maionese, patate fritte.',4.00,'4','Panini'),('Filetto di pesce del giorno all\'eoliana',-1,'pomodoro, sedano, olio extra vergine di oliva, olive verdi, pane, basilico, capperi, uva passa, tonno, salmone, branzino, orata, pinoli, variabile.',16.00,'40','Secondi Di Mare'),('Il pesce fresco del giorno',-1,'alla griglia, al forno, gratinato alla palermitana o in zuppa.',10.00,'41','Secondi Di Mare'),('Braciolette di pesce spada gratinate al forno',-1,'olio extra vergine di oliva, pane, prezzemolo, origano, uva passa, pecorino, pinoli, provola, pesce spada.',14.00,'42','Secondi Di Mare'),('Fritto del golfo di tindari e crema di limoni',-1,'acciughe, latterino, triglia, semola di grano duro, calamari, farina di grano tenero, sale, gamberi, limone, variabile, maionese, olio di arachidi.',16.00,'43','Secondi Di Mare'),('Zuppa di cozze di ganzirri e crostini di pane',-1,'pomodoro, olio extra vergine di oliva, pane, basilico, cozze, origano.',10.00,'44','Secondi Di Mare'),('Grigliata mista di pesce al \"salmurigghiu\" siculo e misticanza fresca',-1,'aceto di vino, olio extra vergine di oliva, calamari, carote, cicoria, indivia, prezzemolo, gamberoni, limone, menta, origano, tonno, salmone, branzino, orata, pesce spada, radicchio, scampi, pepe nero, sale, lattuga, vino bianco, vino rosso, variabile.',20.00,'45','Secondi Di Mare'),('Astice, granchio o aragosta vivi',-1,'aragosta, astice, granciporro.',15.00,'46','Secondi Di Mare'),('Braciolette di vitello alla messinese',-1,'aglio, carne di vitello, olio extra vergine di oliva, pane, carne di manzo, prezzemolo, pecorino, provola.',10.00,'47','Secondi Di Terra'),('Cotoletta di manzo con patatine fritte',-1,'olio extra vergine di oliva, pane, uova di gallina, carne di manzo, noci, semi di girasole, olio di semi di girasole, parmigiano reggiano DOP.',10.00,'48','Secondi Di Terra'),('Cannolo alla ricotta',-1,'farina di grano tenero, scorza di arancia, cacao in polvere, sugna, olio di arachidi, pistacchi, zucchero, burro, brandy, cioccolato, albume d\'uovo di gallina, zucchero a velo, ricotta di pecora.',3.00,'49','Dessert'),('Delicato',-1,'lattuga, pane a lievitazione naturale, prosciutto cotto, provola.',4.00,'5','Panini'),('Coppa di gelato vari gusti',-1,'gelato, variabile.',3.00,'50','Dessert'),('Coppa tiramisù al marsala',-1,'liquore, uova di gallina, cacao in polvere, zucchero, marsala, mascarpone, savoiardi.',3.50,'51','Dessert'),('Tagliata di frutta fresca di stagione',-1,'ananas, pere, melone, mela, uva, cocomero, fragole, kiwi, pesca.',5.00,'52','Dessert'),('I semifreddi del maestro pasticciere',-1,'ananas, pere, melone, mela, uva, anacardi, mandorle, nocciole, noci, panna, semifreddo.',4.00,'53','Dessert'),('La tradizionale torta caprese con gelato alla vaniglia',-1,'uova di gallina, burro, cacao in polvere, cioccolato, cioccolato al latte, zucchero, mandorle, latte di vacca, gelato alla vaniglia.',4.00,'54','Dessert'),('Biscotti secchi tipici o piccola pasticceria con vino liquoroso',-1,'biscotto, vino liquoroso, burro, farina di grano tenero, frutta a guscio (allergene), latte di vacca.',4.00,'55','Dessert'),('Caffé caldo',-1,'caffé.',1.00,'56','Caffetteria'),('Caffé freddo',-1,'caffé.',1.50,'57','Caffetteria'),('Caffé corretto',-1,'caffé.',1.50,'58','Caffetteria'),('Cappuccino',-1,'latte e caffé.',2.00,'59','Caffetteria'),('Sandwich',-1,'pancarré, lattuga, maionese, prosciutto cotto, sottilette, tonno in salamoia sgocciolato.',3.00,'6','Panini'),('Sfogliatina',-1,'pasta sfoglia.',1.50,'60','Caffetteria'),('Ichnusa 33cl',-1,'Birra.',3.00,'61','Birre'),('Peroni 33cl',-1,'Birra.',2.00,'62','Birre'),('Moretti 33cl',-1,'Birra.',2.00,'63','Birre'),('Peroni Chill Lemon 33cl',-1,'Birra.',2.50,'64','Birre'),('Messina Cristalli di Sale 33cl',-1,'Birra.',3.00,'65','Birre'),('Ceres 33cl',-1,'Birra.',4.00,'66','Birre'),('Corona 33cl',-1,'Birra.',4.00,'67','Birre'),('Tennent\'s 33cl',-1,'Birra.',5.00,'68','Birre'),('Bud 33cl',-1,'Birra.',4.00,'69','Birre'),('Delizioso al tonno',-1,'mozzarella, pane a lievitazione naturale, pomodoro cuore di bue, tonno in salamoia sgocciolato, olio di semi di girasole.',4.00,'7','Panini'),('Pilsner Urquell 33cl',-1,'Birra.',3.00,'70','Birre'),('Forst Felsenkeller 33cl',-1,'Birra.',3.00,'71','Birre'),('Goose Island IPA 33cl',-1,'Birra.',5.00,'72','Birre'),('Peroni Forte 33cl',-1,'Birra.',3.50,'73','Birre'),('Gin Tonic',-1,'gin e acqua tonica.',5.00,'74','Cocktails'),('Campari Orange',-1,'campari.',5.00,'75','Cocktails'),('Rum e Cola',-1,'rum e coca cola.',5.00,'76','Cocktails'),('Jack Daniels e Coca',-1,'whiskey e coca cola.',5.00,'77','Cocktails'),('Negroni',-1,'campari, martini rosso, gin.',5.00,'78','Cocktails'),('Americano',-1,'campari, martini rosso, soda.',5.00,'79','Cocktails'),('Vegano alle verdure',-1,'melanzane, peperoni, olio extra vergine di oliva, olive nere, pane a lievitazione naturale, pomodoro cuore di bue, zucchine grigliate.',4.00,'8','Panini'),('Negroni sbagliato',-1,'ampari, artini rosso, prosecco.',5.00,'80','Cocktails'),('Aperol Spritz',-1,'aperol, prosecco, soda.',5.00,'81','Cocktails'),('Moscow Mule',-1,'vodka, succo di lime, ginger beer.',5.00,'82','Cocktails'),('Long Island',-1,'rum, vodka, triple sec, gin, sweet sour, coca cola.',5.00,'83','Cocktails'),('Cosmopolitan',-1,'vodka, succo di lime, triple sec, succo di mirtillo.',5.00,'84','Cocktails'),('Margarita',-1,'tequila, triple sec, succo di lime.',5.00,'85','Cocktails'),('Mojito',-1,'rum scuro, lime a pezzi, zucchero di canna.',5.00,'86','Cocktails'),('Caipirinha',-1,'cachaça, lime a pezzi, zucchero di canna.',5.00,'87','Cocktails'),('Caipiroska',-1,'vodka fragola, lime a pezzi, zucchero di canna.',5.00,'88','Cocktails'),('Pitti',-1,'vermentino IGP BIO torre a cenaia.',20.00,'89','Vini Bianchi'),('Goloso al prosciutto crudo',-1,'pane a lievitazione naturale, pomodoro cuore di bue, prosciutto crudo, provola.',4.00,'9','Panini'),('Traminer Aromatico',-1,'DOC ca\'tullio.',20.00,'90','Vini Bianchi'),('Sauvignon',-1,'DOC ca\'tullio.',20.00,'91','Vini Bianchi'),('Chardonnay',-1,'DOC ca\'tullio.',20.00,'92','Vini Bianchi'),('Pinot Grigio',-1,'DOC ca\'tullio.',20.00,'93','Vini Bianchi'),('Pomino Bianco',-1,'DOC marchesi de\'frescobaldi 2016.',20.00,'94','Vini Bianchi'),('Vernaccia di San Gimignano',-1,'DOCG sensi.',20.00,'95','Vini Bianchi'),('Le Coste',-1,'chianti DOCG giuliano grati.',20.00,'96','Vini Rossi'),('Granaio',-1,'chianti classico DOCG fattorie melini.',20.00,'97','Vini Rossi'),('Calappiano',-1,'sangiovese toscana IGT villa calappiano.',20.00,'98','Vini Rossi'),('La Pieve',-1,'morellino di scansano DOCG f.lli rossi.',20.00,'99','Vini Rossi');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 10:08:36
