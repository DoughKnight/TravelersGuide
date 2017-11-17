CREATE TABLE Country (
    name VARCHAR(40),
    background VARCHAR(4000),
    latitude INT,
    longitude INT,
    area INT,
    PRIMARY KEY(name)
);

CREATE TABLE User (
    uID INT,
    firstname VARCHAR(20),
    lastname VARCHAR(20),
    age INT,
    email VARCHAR(30),
    language VARCHAR(20) REFERENCES Language(name),
    avatar VARCHAR(50),
    country VARCHAR(40) REFERENCES Country(name),
    PRIMARY KEY(uID)
);

CREATE TABLE Connection (
    uID1 INT REFERENCES User(uID),
    uID2 INT REFERENCES User(uID),
    meetDate DATE,
    PRIMARY KEY(uID1, uID2)
);

CREATE TABLE Recommendation (
    uID INT REFERENCES User(uID),
    name VARCHAR(40) REFERENCES Country(name),
    stars INT,
    opinion VARCHAR(200),
    PRIMARY KEY(uID, name)
);

CREATE TABLE Boundaries (
    name1 VARCHAR(40) REFERENCES Country(name),
    name2 VARCHAR(40) REFERENCES Country(name),
    length INT,
    PRIMARY KEY(name1, name2)
);

CREATE TABLE Languages (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    country VARCHAR(40) REFERENCES Country(name),
    percent FLOAT
);

CREATE TABLE Industries (
    id INT PRIMARY KEY,
    country VARCHAR(40) REFERENCES Country(name),
    industry VARCHAR(20)
);

CREATE TABLE Economy (
    country VARCHAR(40) REFERENCES Country(name),
    growthRate FLOAT,
    perCapita INT,
    agricultural FLOAT,
    industry FLOAT,
    services FLOAT,
    povertyLine FLOAT,
    PRIMARY KEY(country)
);

DELIMITER //
CREATE TRIGGER SumLanguage
AFTER UPDATE ON Languages
FOR EACH ROW
BEGIN
    UPDATE Languages
    SET percent = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT percent FROM Languages AS l WHERE l.country = NEW.country)
    OR 100 <> (SELECT SUM(percent) FROM Languages AS l2 WHERE l2.country = NEW.country));
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER SumEcon
AFTER UPDATE ON Economy
FOR EACH ROW
BEGIN
    UPDATE Economy
    SET agriculture = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
    UPDATE Economy
    SET industry = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
    UPDATE Economy
    SET services = 0
    WHERE country = NEW.country
    AND (0 IN (SELECT agriculture FROM Economy as c WHERE c.country = NEW.country)
        OR 0 IN (SELECT industry FROM Economy as c2  WHERE c2.country = NEW.country)
        OR 0 IN (SELECT services FROM Economy as c3 WHERE c3.country = NEW.country)
        OR 100 <> (SELECT (c4.agriculture + c4.industry + c4.services) as total FROM Economy as c4 WHERE c4.country = NEW.country));
END//
DELIMITER ;

INSERT INTO Country VALUES ("Afghanistan", "Ahmad Shah DURRANI unified the Pashtun tribes and founded Afghanistan in 1747. The country served as a buffer between the British and Russian Empires until it won independence from notional British control in 1919. A brief experiment in democracy ended in a 1973 coup and a 1978 communist counter-coup. The Soviet Union invaded in 1979 to support the tottering Afghan communist regime, touching off a long and destructive war. The USSR withdrew in 1989 under relentless pressure by internationally supported anti-communist mujahedin rebels. A series of subsequent civil wars saw Kabul finally fall in 1996 to the Taliban, a hardline Pakistani-sponsored movement that emerged in 1994 to end the country's civil war and anarchy. Following the 11 September 2001 terrorist attacks, a US, Allied, and anti-Taliban Northern Alliance military action toppled the Taliban for sheltering Osama BIN LADIN. The UN-sponsored Bonn Conference in 2001 established a process for political reconstruction that included the adoption of a new constitution, a presidential election in 2004, and National Assembly elections in 2005. In December 2004, Hamid KARZAI became the first democratically elected president of Afghanistan and the National Assembly was inaugurated the following December. KARZAI was re-elected in August 2009 for a second term. Despite gains toward building a stable central government, a resurgent Taliban and continuing provincial instability - particularly in the south and the east - remain serious challenges for the Afghan Government. ", 33.00, 65.00, 652230);

INSERT INTO Country VALUES ("Akrotiri", "By terms of the 1960 Treaty of Establishment that created the independent Republic of Cyprus, the UK retained full sovereignty and jurisdiction over two areas of almost 254 square kilometers - Akrotiri and Dhekelia. The southernmost and smallest of these is the Akrotiri Sovereign Base Area, which is also referred to as the Western Sovereign Base Area. ", 34.37, 32.58, 123);

INSERT INTO Country VALUES ("Albania", "Albania declared its independence from the Ottoman Empire in 1912, but was conquered by Italy in 1939, and occupied by Germany in 1943. Communist partisans took over the country in 1944. Albania allied itself first with the USSR (until 1960), and then with China (to 1978). In the early 1990s, Albania ended 46 years of xenophobic communist rule and established a multiparty democracy. The transition has proven challenging as successive governments have tried to deal with high unemployment, widespread corruption, dilapidated infrastructure, powerful organized crime networks, and combative political opponents. Albania has made progress in its democratic development since first holding multiparty elections in 1991, but deficiencies remain. International observers judged elections to be largely free and fair since the restoration of political stability following the collapse of pyramid schemes in 1997; however, each of Albania's post-communist elections have been marred by claims of electoral fraud. The 2009 general elections resulted in a coalition government, the first such in the country's history. In 2013, general elections achieved a peaceful transition of power and a second successive coalition government. Albania joined NATO in April 2009 and is a potential candidate for EU accession. Although Albania's economy continues to grow, it has slowed, and the country is still one of the poorest in Europe. A large informal economy and an inadequate energy and transportation infrastructure remain obstacles. ", 41.00, 20.00, 28748);

INSERT INTO Country VALUES ("Algeria", "After more than a century of rule by France, Algerians fought through much of the 1950s to achieve independence in 1962. Algeria's primary political party, the National Liberation Front (FLN), was established in 1954 as part of the struggle for independence and has largely dominated politics since. The Government of Algeria in 1988 instituted a multi-party system in response to public unrest, but the surprising first round success of the Islamic Salvation Front (FIS) in the December 1991 balloting led the Algerian army to intervene and postpone the second round of elections to prevent what the secular elite feared would be an extremist-led government from assuming power. The army began a crackdown on the FIS that spurred FIS supporters to begin attacking government targets. Fighting escalated into an insurgency, which saw intense violence from 1992-98, resulting in over 100,000 deaths - many attributed to indiscriminate massacres of villagers by extremists. The government gained the upper hand by the late-1990s, and FIS's armed wing, the Islamic Salvation Army, disbanded in January 2000. Abdelaziz BOUTEFLIKA, with the backing of the military, won the presidency in 1999 in an election widely viewed as fraudulent. He was reelected to a second term in 2004 and overwhelmingly won a third term in 2009, after the government amended the constitution in 2008 to remove presidential term limits. Longstanding problems continue to face BOUTEFLIKA, including large-scale unemployment, a shortage of housing, unreliable electrical and water supplies, government inefficiencies and corruption, and the continuing activities of extremist militants. The Salafist Group for Preaching and Combat (GSPC) in 2006 merged with al-Qa'ida to form al-Qa'ida in the Lands of the Islamic Maghreb, which has launched an ongoing series of kidnappings and bombings targeting the Algerian Government and Western interests. The government in 2011 introduced some political reforms in response to the Arab Spring, including lifting the 19-year-old state of emergency restrictions and increasing women's quotas for elected assemblies. Parliamentary elections in May 2012 and municipal and provincial elections in November 2012 saw continued dominance by the FLN, with Islamist opposition parties performing poorly. Political protest activity in the country remained low in 2013, but small, sometimes violent socioeconomic demonstrations by disparate groups continued to be a common occurrence. Parliament in 2014 is expected to revise the constitution. ", 28.00, 3.00, 2381741);

INSERT INTO Country VALUES ("American Samoa", "Settled as early as 1000 B.C., Samoa was not reached by European explorers until the 18th century. International rivalries in the latter half of the 19th century were settled by an 1899 treaty in which Germany and the US divided the Samoan archipelago. The US formally occupied its portion - a smaller group of eastern islands with the excellent harbor of Pago Pago - the following year. ", 14.20, 170.00, 199);

INSERT INTO Country VALUES ("Andorra", "The landlocked Principality of Andorra is one of the smallest states in Europe, nestled high in the Pyrenees between the French and Spanish borders. For 715 years, from 1278 to 1993, Andorrans lived under a unique co-principality, ruled by French and Spanish leaders (from 1607 onward, the French chief of state and the Bishop of Urgell). In 1993, this feudal system was modified with the introduction of a modern, constitution; the co-princes remained as titular heads of state, but the government transformed into a parliamentary democracy. Andorra has become a popular tourist destination visited by approximately ten million people each year drawn by the winter sports, summer climate, and duty-free shopping. Andorra has also become a wealthy international commercial center because of its mature banking sector and low taxes. As part of its effort to modernize its economy, Andorra has opened to foreign investment, and engaged in other reforms, such as advancing tax initiatives aimed at supporting a broader infrastructure. Although not a member of the European Union (EU), Andorra enjoys a special relationship with the EU and uses the euro as its national currency. ", 42.30, 1.30, 468);

INSERT INTO Country VALUES ("Angola", "Angola is still rebuilding its country since the end of a 27-year civil war in 2002. Fighting between the Popular Movement for the Liberation of Angola (MPLA), led by Jose Eduardo DOS SANTOS, and the National Union for the Total Independence of Angola (UNITA), led by Jonas SAVIMBI, followed independence from Portugal in 1975. Peace seemed imminent in 1992 when Angola held national elections, but fighting picked up again in 1993. Up to 1.5 million lives may have been lost - and 4 million people displaced - during the more than a quarter century of fighting. SAVIMBI's death in 2002 ended UNITA's insurgency and cemented the MPLA's hold on power. President DOS SANTOS pushed through a new constitution in 2010; elections held in 2012 saw him installed as president. ", 12.30, 18.30, 1246700);

INSERT INTO Country VALUES ("Anguilla", "Colonized by English settlers from Saint Kitts in 1650, Anguilla was administered by Great Britain until the early 19th century, when the island - against the wishes of the inhabitants - was incorporated into a single British dependency along with Saint Kitts and Nevis. Several attempts at separation failed. In 1971, two years after a revolt, Anguilla was finally allowed to secede; this arrangement was formally recognized in 1980, with Anguilla becoming a separate British dependency. ", 18.15, 63.10, 91);

INSERT INTO Country VALUES ("Antarctica", "Speculation over the existence of a ''southern land'' was not confirmed until the early 1820s when British and American commercial operators and British and Russian national expeditions began exploring the Antarctic Peninsula region and other areas south of the Antarctic Circle. Not until 1840 was it established that Antarctica was indeed a continent and not just a group of islands or an area of ocean. Several exploration ''firsts'' were achieved in the early 20th century, but generally the area saw little human activity. Following World War II, however, the continent experienced an upsurge in scientific research. A number of countries have set up a range of year-round and seasonal stations, camps, and refuges to support scientific research in Antarctica. Seven have made territorial claims, but not all countries recognize these claims. In order to form a legal framework for the activities of nations on the continent, an Antarctic Treaty was negotiated that neither denies nor gives recognition to existing territorial claims; signed in 1959, it entered into force in 1961. ", 90.00, 0.00, 14000000);

INSERT INTO Country VALUES ("Antigua and Barbuda", "The Siboney were the first people to inhabit the islands of Antigua and Barbuda in 2400 B.C., but Arawak Indians populated the islands when COLUMBUS landed on his second voyage in 1493. Early Spanish and French settlements were succeeded by an English colony in 1667. Slavery, established to run the sugar plantations on Antigua, was abolished in 1834. The islands became an independent state within the British Commonwealth of Nations in 1981. ", 17.03, 61.48, 442);

INSERT INTO Country VALUES ("Argentina", "In 1816, the United Provinces of the Rio Plata declared their independence from Spain. After Bolivia, Paraguay, and Uruguay went their separate ways, the area that remained became Argentina. The country's population and culture were heavily shaped by immigrants from throughout Europe, with Italy and Spain providing the largest percentage of newcomers from 1860 to 1930. Up until about the mid-20th century, much of Argentina's history was dominated by periods of internal political conflict between Federalists and Unitarians and between civilian and military factions. After World War II, an era of Peronist populism and direct and indirect military interference in subsequent governments was followed by a military junta that took power in 1976. Democracy returned in 1983 after a failed bid to seize the Falkland Islands (Islas Malvinas) by force, and has persisted despite numerous challenges, the most formidable of which was a severe economic crisis in 2001-02 that led to violent public protests and the successive resignations of several presidents. In January 2013, Argentina assumed a nonpermanent seat on the UN Security Council for the 2013-14 term. ", 34.00, 64.00, 2780400);

INSERT INTO Country VALUES ("Armenia", "Armenia prides itself on being the first nation to formally adopt Christianity (early 4th century). Despite periods of autonomy, over the centuries Armenia came under the sway of various empires including the Roman, Byzantine, Arab, Persian, and Ottoman. During World War I in the western portion of Armenia, Ottoman Turkey instituted a policy of forced resettlement coupled with other harsh practices that resulted in at least 1 million Armenian deaths. The eastern area of Armenia was ceded by the Ottomans to Russia in 1828; this portion declared its independence in 1918, but was conquered by the Soviet Red Army in 1920. Armenian leaders remain preoccupied by the long conflict with Azerbaijan over Nagorno-Karabakh, a primarily Armenian-populated region, assigned to Soviet Azerbaijan in the 1920s by Moscow. Armenia and Azerbaijan began fighting over the area in 1988; the struggle escalated after both countries attained independence from the Soviet Union in 1991. By May 1994, when a cease-fire took hold, ethnic Armenian forces held not only Nagorno-Karabakh but also a significant portion of Azerbaijan proper. The economies of both sides have been hurt by their inability to make substantial progress toward a peaceful resolution. Turkey closed the common border with Armenia in 1993 in support of Azerbaijan in its conflict with Armenia over control of Nagorno-Karabakh and surrounding areas, further hampering Armenian economic growth. In 2009, senior Armenian leaders began pursuing rapprochement with Turkey, aiming to secure an opening of the border, but Turkey has not yet ratified the Protocols normalizing relations between the two countries. In September 2013, President SARGSIAN announced Armenia would join Russia, Belarus, and Kazakhstan as a member of the Eurasian Economic Union. ", 40.00, 45.00, 29743);

INSERT INTO Country VALUES ("Aruba", "Discovered and claimed for Spain in 1499, Aruba was acquired by the Dutch in 1636. The island's economy has been dominated by three main industries. A 19th century gold rush was followed by prosperity brought on by the opening in 1924 of an oil refinery. The last decades of the 20th century saw a boom in the tourism industry. Aruba seceded from the Netherlands Antilles in 1986 and became a separate, autonomous member of the Kingdom of the Netherlands. Movement toward full independence was halted at Aruba's request in 1990. ", 12.30, 69.58, 180);

INSERT INTO Country VALUES ("Ashmore and Cartier Islands", "These uninhabited islands came under Australian authority in 1931; formal administration began two years later. Ashmore Reef supports a rich and diverse avian and marine habitat; in 1983, it became a National Nature Reserve. Cartier Island, a former bombing range, became a marine reserve in 2000. ", 12.14, 123.05, 5);

INSERT INTO Country VALUES ("Australia", "Prehistoric settlers arrived on the continent from Southeast Asia at least 40,000 years before the first Europeans began exploration in the 17th century. No formal territorial claims were made until 1770, when Capt. James COOK took possession of the east coast in the name of Great Britain (all of Australia was claimed as British territory in 1829 with the creation of the colony of Western Australia). Six colonies were created in the late 18th and 19th centuries; they federated and became the Commonwealth of Australia in 1901. The new country took advantage of its natural resources to rapidly develop agricultural and manufacturing industries and to make a major contribution to the Allied effort in World Wars I and II. In recent decades, Australia has become an internationally competitive, advanced market economy due in large part to economic reforms adopted in the 1980s and its location in one of the fastest growing regions of the world economy. Long-term concerns include aging of the population, pressure on infrastructure, and environmental issues such as floods, droughts, and bushfires. Australia is the driest inhabited continent on earth, making it particularly vulnerable to the challenges of climate change. Australia is home to 10 per cent of the world's biodiversity, and a great number of its flora and fauna exist nowhere else in the world. In January 2013, Australia assumed a nonpermanent seat on the UN Security Council for the 2013-14 term. ", 27.00, 133.00, 7741220);

INSERT INTO Country VALUES ("Austria", "Once the center of power for the large Austro-Hungarian Empire, Austria was reduced to a small republic after its defeat in World War I. Following annexation by Nazi Germany in 1938 and subsequent occupation by the victorious Allies in 1945, Austria's status remained unclear for a decade. A State Treaty signed in 1955 ended the occupation, recognized Austria's independence, and forbade unification with Germany. A constitutional law that same year declared the country's ''perpetual neutrality'' as a condition for Soviet military withdrawal. The Soviet Union's collapse in 1991 and Austria's entry into the European Union in 1995 have altered the meaning of this neutrality. A prosperous, democratic country, Austria entered the EU Economic and Monetary Union in 1999. ", 47.20, 13.20, 83871);

INSERT INTO Country VALUES ("Azerbaijan", "Azerbaijan - a nation with a majority-Turkic and majority-Shia Muslim population - was briefly independent (from 1918 to 1920) following the collapse of the Russian Empire; it was subsequently incorporated into the Soviet Union for seven decades. Azerbaijan has yet to resolve its conflict with Armenia over Nagorno-Karabakh, a primarily Armenian-populated region that Moscow recognized in 1923 as an autonomous republic within Soviet Azerbaijan after Armenia and Azerbaijan disputed the territory's status. Armenia and Azerbaijan began fighting over the area in 1988; the struggle escalated after both countries attained independence from the Soviet Union in 1991. By May 1994, when a cease-fire took hold, ethnic Armenian forces held not only Nagorno-Karabakh but also seven surrounding provinces in the territory of Azerbaijan. The OSCE Minsk Group, co-chaired by the United States, France, and Russia, is the framework established to mediate a peaceful resolution of the conflict. Corruption in the country is widespread, and the government, which eliminated presidential term limits in a 2009 referendum, has been accused of authoritarianism. Although the poverty rate has been reduced and infrastructure investment has increased substantially in recent years due to revenue from oil and gas production, reforms have not adequately addressed weaknesses in most government institutions, particularly in the education and health sectors. ", 40.30, 47.30, 86600);

INSERT INTO Country VALUES ("Bahamas, The", "Lucayan Indians inhabited the islands when Christopher COLUMBUS first set foot in the New World on San Salvador in 1492. British settlement of the islands began in 1647; the islands became a colony in 1783. Since attaining independence from the UK in 1973, The Bahamas has prospered through tourism, international banking, and investment management. Because of its location, the country is a major transshipment point for illegal drugs, particularly shipments to the US and Europe, and its territory is used for smuggling illegal migrants into the US. ", 24.15, 76.00, 13880);

INSERT INTO Country VALUES ("Bahrain", "In 1783, the Sunni Al-Khalifa family took power in Bahrain. In order to secure these holdings, it entered into a series of treaties with the UK during the 19th century that made Bahrain a British protectorate. The archipelago attained its independence in 1971. Facing declining oil reserves, Bahrain has turned to petroleum processing and refining and has become an international banking center. Bahrain's small size and central location among Gulf countries require it to play a delicate balancing act in foreign affairs among its larger neighbors. The Sunni-led government has struggled to manage relations with its large Shia-majority population. In early 2011, amid Arab uprisings elsewhere in the region, the Bahraini Government confronted similar protests at home with police and military action, including deploying Gulf Cooperation Council security forces to Bahrain. Sporadic clashes between demonstrators and security forces continue in Bahrain. Ongoing dissatisfaction with the political status quo has led to a broader discussion termed the Bahrain National Dialogue, a process that convenes members of the executive, parliament, and political societies in an attempt to reach a political agreement. ", 26.00, 50.33, 760);

INSERT INTO Country VALUES ("Bangladesh", "Muslim conversions and settlement in the region now referred to as Bangladesh began in the 10th century, primarily from Arab and Persian traders and preachers. Europeans began to set up trading posts in the area in the 16th century. Eventually the area known as Bengal, primarily Hindu in the western section and mostly Muslim in the eastern half, became part of British India. Partition in 1947 resulted in an eastern wing of Pakistan in the Muslim-majority area, which became East Pakistan. Calls for greater autonomy and animosity between the eastern and western wings of Pakistan led to a Bengali independence movement. That movement, led by the Awami League (AL) and supported by India, won independence for Bangladesh in a brief war in 1971, during which at least 300,000 civilians died. The post-independence, AL government faced daunting challenges and in 1975 was overthrown by the military, triggering a series of military coups that resulted in a military-backed government and subsequent creation of the Bangladesh Nationalist Party (BNP). That government also ended in a coup in 1981, followed by military-backed rule until democratic elections in 1991. The BNP and AL have alternately held power since then, with the exception of a military-backed, emergency caretaker regime that suspended parliamentary elections planned for January 2007 in an effort to reform the political system and root out corruption. That government returned the country to fully democratic rule in December 2008 with the election of the AL and Prime Minister Sheikh HASINA. In January 2014, the AL won the national election by an overwhelming majority after the BNP boycotted, extending HASINA's term as prime minister. With the help of international development assistance, Bangladesh has made great progress in food security since independence, and the economy has grown at an average of about 6 percent over the last two decades. ", 24.00, 90.00, 143998);

INSERT INTO Country VALUES ("Barbados", "The island was uninhabited when first settled by the British in 1627. African slaves worked the sugar plantations established on the island until 1834 when slavery was abolished. The economy remained heavily dependent on sugar, rum, and molasses production through most of the 20th century. The gradual introduction of social and political reforms in the 1940s and 1950s led to complete independence from the UK in 1966. In the 1990s, tourism and manufacturing surpassed the sugar industry in economic importance. ", 13.10, 59.32, 430);

INSERT INTO Country VALUES ("Belarus", "After seven decades as a constituent republic of the USSR, Belarus attained its independence in 1991. It has retained closer political and economic ties to Russia than have any of the other former Soviet republics. Belarus and Russia signed a treaty on a two-state union on 8 December 1999 envisioning greater political and economic integration. Although Belarus agreed to a framework to carry out the accord, serious implementation has yet to take place. Since his election in July 1994 as the country's first directly elected president, Aleksandr LUKASHENKO has steadily consolidated his power through authoritarian means and a centralized economic system. Government restrictions on freedom of speech and the press, peaceful assembly, and religion remain in place. ", 53.00, 28.00, 207600);

INSERT INTO Country VALUES ("Belgium", "Belgium became independent from the Netherlands in 1830; it was occupied by Germany during World Wars I and II. The country prospered in the past half century as a modern, technologically advanced European state and member of NATO and the EU. Political divisions between the Dutch-speaking Flemings of the north and the French-speaking Walloons of the south have led in recent years to constitutional amendments granting these regions formal recognition and autonomy. Its capital, Brussels, is home to numerous international organizations including the EU and NATO. ", 50.50, 4.00, 30528);

INSERT INTO Country VALUES ("Belize", "Belize was the site of several Mayan city states until their decline at the end of the first millennium A.D. The British and Spanish disputed the region in the 17th and 18th centuries; it formally became the colony of British Honduras in 1854. Territorial disputes between the UK and Guatemala delayed the independence of Belize until 1981. Guatemala refused to recognize the new nation until 1992 and the two countries are involved in an ongoing border dispute. Tourism has become the mainstay of the economy. Current concerns include the country's heavy foreign debt burden, high unemployment, growing involvement in the Mexican and South American drug trade, high crime rates, and one of the highest HIV/AIDS prevalence rates in Central America. ", 17.15, 88.45, 22966);

INSERT INTO Country VALUES ("Benin", "Present day Benin was the site of Dahomey, a West African kingdom that rose to prominence in about 1600 and over the next two and half centuries became a regional power, largely based on its slave trade. Coastal areas of Dahomey began to be controlled by the French in the second half of the 19th century; the entire kingdom was conquered by 1894. French Dahomey achieved independence in 1960; it changed its name to the Republic of Benin in 1975. A succession of military governments ended in 1972 with the rise to power of Mathieu KEREKOU and the establishment of a government based on Marxist-Leninist principles. A move to representative government began in 1989. Two years later, free elections ushered in former Prime Minister Nicephore SOGLO as president, marking the first successful transfer of power in Africa from a dictatorship to a democracy. KEREKOU was returned to power by elections held in 1996 and 2001, though some irregularities were alleged. KEREKOU stepped down at the end of his second term in 2006 and was succeeded by Thomas YAYI Boni, a political outsider and independent. YAYI, who won a second five-year term in March 2011, has attempted to stem corruption and has strongly promoted accelerating Benin's economic growth. ", 9.30, 2.15, 112622);

INSERT INTO Country VALUES ("Bermuda", "Bermuda was first settled in 1609 by shipwrecked English colonists headed for Virginia. Self-governing since 1620, Bermuda is the oldest and most populous of the British overseas territories. Vacationing to the island to escape North American winters first developed in Victorian times. Tourism continues to be important to the island's economy, although international business has overtaken it in recent years. Bermuda has also developed into a highly successful offshore financial center. A referendum on independence from the UK was soundly defeated in 1995. ", 32.20, 64.45, 54);

INSERT INTO Country VALUES ("Bhutan", "In 1865, Britain and Bhutan signed the Treaty of Sinchulu, under which Bhutan would receive an annual subsidy in exchange for ceding some border land to British India. Under British influence, a monarchy was set up in 1907; three years later, a treaty was signed whereby the British agreed not to interfere in Bhutanese internal affairs, and Bhutan allowed Britain to direct its foreign affairs. This role was assumed by independent India after 1947. Two years later, a formal Indo-Bhutanese accord returned to Bhutan the areas annexed by the British, formalized the annual subsidies the country received, and defined India's responsibilities in defense and foreign relations. In March 2005, King Jigme Singye WANGCHUCK unveiled the government's draft constitution - which introduced major democratic reforms - and pledged to hold a national referendum for its approval. In December 2006, the King abdicated the throne in favor of his son, Jigme Khesar Namgyel WANGCHUCK, in order to give him experience as head of state before the democratic transition. In early 2007, India and Bhutan renegotiated their treaty, eliminating the clause that stated that Bhutan would be ''guided by'' India in conducting its foreign policy, although Thimphu continues to coordinate closely with New Delhi. Elections for seating the country's first parliament were completed in March 2008; the king ratified the country's first constitution in July 2008. Bhutan experienced a peaceful turnover of power following parliamentary elections in 2013, which routed the incumbent party. The disposition of some 30,000 Bhutanese refugees - housed in two UN refugee camps in Nepal - remains unresolved. ", 27.30, 90.30, 38394);

INSERT INTO Country VALUES ("Bolivia", "Bolivia, named after independence fighter Simon BOLIVAR, broke away from Spanish rule in 1825; much of its subsequent history has consisted of a series of nearly 200 coups and countercoups. Democratic civilian rule was established in 1982, but leaders have faced difficult problems of deep-seated poverty, social unrest, and illegal drug production. In December 2005, Bolivians elected Movement Toward Socialism leader Evo MORALES president - by the widest margin of any leader since the restoration of civilian rule in 1982 - after he ran on a promise to change the country's traditional political class and empower the nation's poor, indigenous majority. In December 2009, President MORALES easily won reelection, and his party took control of the legislative branch of the government, which will allow him to continue his process of change. In October 2011, the country held its first judicial elections to select judges for the four highest courts. ", 17.00, 65.00, 1098581);

INSERT INTO Country VALUES ("Bosnia and Herzegovina", "Bosnia and Herzegovina declared sovereignty in October 1991 and independence from the former Yugoslavia on 3 March 1992 after a referendum boycotted by ethnic Serbs. The Bosnian Serbs - supported by neighboring Serbia and Montenegro - responded with armed resistance aimed at partitioning the republic along ethnic lines and joining Serb-held areas to form a ''Greater Serbia.'' In March 1994, Bosniaks and Croats reduced the number of warring factions from three to two by signing an agreement creating a joint Bosniak/Croat Federation of Bosnia and Herzegovina. On 21 November 1995, in Dayton, Ohio, the warring parties initialed a peace agreement that ended three years of interethnic civil strife (the final agreement was signed in Paris on 14 December 1995). The Dayton Peace Accords retained Bosnia and Herzegovina's international boundaries and created a multi-ethnic and democratic government charged with conducting foreign, diplomatic, and fiscal policy. Also recognized was a second tier of government composed of two entities roughly equal in size: the Bosniak/Bosnian Croat Federation of Bosnia and Herzegovina and the Bosnian Serb-led Republika Srpska (RS). The Federation and RS governments are responsible for overseeing most government functions. Additionally, the Dayton Accords established the Office of the High Representative (OHR) to oversee the implementation of the civilian aspects of the agreement. The Peace Implementation Council (PIC) at its conference in Bonn in 1997 also gave the High Representative the authority to impose legislation and remove officials, the so-called ''Bonn Powers.'' An original NATO-led international peacekeeping force (IFOR) of 60,000 troops assembled in 1995 was succeeded over time by a smaller, NATO-led Stabilization Force (SFOR). In 2004, European Union peacekeeping troops (EUFOR) replaced SFOR. Currently EUFOR deploys around 600 troops in theater in a policing capacity. ", 44.00, 18.00, 51197);

INSERT INTO Country VALUES ("Botswana", "Formerly the British protectorate of Bechuanaland, Botswana adopted its new name upon independence in 1966. More than four decades of uninterrupted civilian leadership, progressive social policies, and significant capital investment have created one of the most stable economies in Africa. Mineral extraction, principally diamond mining, dominates economic activity, though tourism is a growing sector due to the country's conservation practices and extensive nature preserves. Botswana has one of the world's highest known rates of HIV/AIDS infection, but also one of Africa's most progressive and comprehensive programs for dealing with the disease. ", 22.00, 24.00, 581730);

INSERT INTO Country VALUES ("Bouvet Island", "This uninhabited, volcanic, Antarctic island is almost entirely covered by glaciers making it difficult to approach; it is recognized as the most remote island on Earth. Bouvet Island was discovered in 1739 by a French naval officer after whom it is named. No claim was made until 1825, when the British flag was raised. In 1928, the UK waived its claim in favor of Norway, which had occupied the island the previous year. In 1971, Norway designated Bouvet Island and the adjacent territorial waters a nature reserve. Since 1977, Norway has run an automated meteorological station and studied foraging strategies and distribution of fur seals and penguins on the island. ", 54.26, 3.24, 49);

INSERT INTO Country VALUES ("Brazil", "Following more than three centuries under Portuguese rule, Brazil gained its independence in 1822, maintaining a monarchical system of government until the abolition of slavery in 1888 and the subsequent proclamation of a republic by the military in 1889. Brazilian coffee exporters politically dominated the country until populist leader Getulio VARGAS rose to power in 1930. By far the largest and most populous country in South America, Brazil underwent more than a half century of populist and military government until 1985, when the military regime peacefully ceded power to civilian rulers. Brazil continues to pursue industrial and agricultural growth and development of its interior. Exploiting vast natural resources and a large labor pool, it is today South America's leading economic power and a regional leader, one of the first in the area to begin an economic recovery. High income inequality and crime remain pressing problems, as well as recent years' slow down in economic growth. ", 10.00, 55.00, 8514877);

INSERT INTO Country VALUES ("British Indian Ocean Territory", "Formerly administered as part of the British Crown Colony of Mauritius, the British Indian Ocean Territory (BIOT) was established as an overseas territory of the UK in 1965. A number of the islands of the territory were later transferred to the Seychelles when it attained independence in 1976. Subsequently, BIOT has consisted only of the six main island groups comprising the Chagos Archipelago. The largest and most southerly of the islands, Diego Garcia, contains a joint UK-US naval support facility. All of the remaining islands are uninhabited. Between 1967 and 1973, former agricultural workers, earlier residents in the islands, were relocated primarily to Mauritius, but also to the Seychelles. Negotiations between 1971 and 1982 resulted in the establishment of a trust fund by the British Government as compensation for the displaced islanders, known as Chagossians. Beginning in 1998, the islanders pursued a series of lawsuits against the British Government seeking further compensation and the right to return to the territory. In 2006 and 2007, British court rulings invalidated the immigration policies contained in the 2004 BIOT Constitution Order that had excluded the islanders from the archipelago, but upheld the special military status of Diego Garcia. In 2008, the House of Lords, as the final court of appeal in the UK, ruled in favor of the British Government by overturning the lower court rulings and finding no right of return for the Chagossians. ", 6.00, 71.30, 54400);

INSERT INTO Country VALUES ("British Virgin Islands", "First inhabited by Arawak and later by Carib Indians, the Virgin Islands were settled by the Dutch in 1648 and then annexed by the English in 1672. The islands were part of the British colony of the Leeward Islands from 1872-1960; they were granted autonomy in 1967. The economy is closely tied to the larger and more populous US Virgin Islands to the west; the US dollar is the legal currency. ", 18.30, 64.30, 151);

INSERT INTO Country VALUES ("Brunei", "The Sultanate of Brunei's influence peaked between the 15th and 17th centuries when its control extended over coastal areas of northwest Borneo and the southern Philippines. Brunei subsequently entered a period of decline brought on by internal strife over royal succession, colonial expansion of European powers, and piracy. In 1888, Brunei became a British protectorate; independence was achieved in 1984. The same family has ruled Brunei for over six centuries. Brunei benefits from extensive petroleum and natural gas fields, the source of one of the highest per capita GDPs in Asia. ", 4.30, 114.40, 5765);

INSERT INTO Country VALUES ("Bulgaria", "The Bulgars, a Central Asian Turkic tribe, merged with the local Slavic inhabitants in the late 7th century to form the first Bulgarian state. In succeeding centuries, Bulgaria struggled with the Byzantine Empire to assert its place in the Balkans, but by the end of the 14th century the country was overrun by the Ottoman Turks. Northern Bulgaria attained autonomy in 1878 and all of Bulgaria became independent from the Ottoman Empire in 1908. Having fought on the losing side in both World Wars, Bulgaria fell within the Soviet sphere of influence and became a People's Republic in 1946. Communist domination ended in 1990, when Bulgaria held its first multiparty election since World War II and began the contentious process of moving toward political democracy and a market economy while combating inflation, unemployment, corruption, and crime. The country joined NATO in 2004 and the EU in 2007. ", 43.00, 25.00, 110879);

INSERT INTO Country VALUES ("Burkina Faso", "Burkina Faso (formerly Upper Volta) achieved independence from France in 1960. Repeated military coups during the 1970s and 1980s were followed by multiparty elections in the early 1990s. Current President Blaise COMPAORE came to power in a 1987 military coup and has won every election since then. There have been increasing protests over the belief that the president may try to run for a currently unconstitutional third term in the 2015 presidential elections. Burkina Faso's high population growth and limited natural resources result in poor economic prospects for the majority of its citizens. ", 13.00, 2.00, 274200);

INSERT INTO Country VALUES ("Burma", "Various ethnic Burmese and ethnic minority city-states or kingdoms occupied the present borders through the 19th century. Over a period of 62 years (1824-1886), Britain conquered Burma and incorporated the country into its Indian Empire. Burma was administered as a province of India until 1937 when it became a separate, self-governing colony; in 1948, Burma attained independence from the British Commonwealth. Gen. NE WIN dominated the government from 1962 to 1988, first as military ruler, then as self-appointed president, and later as political kingpin. In response to widespread civil unrest, NE WIN resigned in 1988, but within months the military crushed student-led protests and took power. Multiparty legislative elections in 1990 resulted in the main opposition party - the National League for Democracy (NLD) - winning a landslide victory. Instead of handing over power, the junta placed NLD leader (and Nobel Peace Prize recipient) AUNG SAN SUU KYI (ASSK) under house arrest from 1989 to 1995, 2000 to 2002, and from May 2003 to November 2010. In late September 2007, the ruling junta brutally suppressed protests over increased fuel prices led by prodemocracy activists and Buddhist monks, killing at least 13 people and arresting thousands for participating in the demonstrations. In early May 2008, Burma was struck by Cyclone Nargis, which left over 138,000 dead and tens of thousands injured and homeless. Despite this tragedy, the junta proceeded with its May constitutional referendum, the first vote in Burma since 1990. Parliamentary elections held in November 2010, considered flawed by many in the international community, saw the ruling Union Solidarity and Development Party garner over 75% of the seats. Parliament convened in January 2011 and selected former Prime Minister THEIN SEIN as president. Although the vast majority of national-level appointees named by THEIN SEIN are former or current military officers, the government has initiated a series of political and economic reforms leading to a substantial opening of the long-isolated country. These reforms have included allowing ASSK to contest parliamentary by-elections on 1 April 2012, releasing hundreds of political prisoners, reaching preliminary peace agreements with 10 of the 11 major armed ethnic groups, enacting laws that provide better protections for basic human rights, and gradually reducing restrictions on freedom of the press, association, and civil society. At least due in part to these reforms, ASSK now serves as an elected Member of Parliament and chair of the Committee for Rule of Law and Tranquility. Most political parties have begun building their institutions in preparation for the next round of general elections in 2015. The country is the chair of the Association of Southeast Asian Nations (ASEAN) for 2014. ", 22.00, 98.00, 676578);

INSERT INTO Country VALUES ("Burundi", "Burundi's first democratically elected president was assassinated in October 1993 after only 100 days in office, triggering widespread ethnic violence between Hutu and Tutsi factions. More than 200,000 Burundians perished during the conflict that spanned almost a dozen years. Hundreds of thousands of Burundians were internally displaced or became refugees in neighboring countries. An internationally brokered power-sharing agreement between the Tutsi-dominated government and the Hutu rebels in 2003 paved the way for a transition process that led to an integrated defense force, established a new constitution in 2005, and elected a majority Hutu government in 2005. The government of President Pierre NKURUNZIZA, who was reelected in 2010, continues to face many political and economic challenges. ", 3.30, 30.00, 27830);

INSERT INTO Country VALUES ("Cabo Verde", "The uninhabited islands were discovered and colonized by the Portuguese in the 15th century; Cabo Verde subsequently became a trading center for African slaves and later an important coaling and resupply stop for whaling and transatlantic shipping. Following independence in 1975, and a tentative interest in unification with Guinea-Bissau, a one-party system was established and maintained until multi-party elections were held in 1990. Cabo Verde continues to exhibit one of Africa's most stable democratic governments. Repeated droughts during the second half of the 20th century caused significant hardship and prompted heavy emigration. As a result, Cabo Verde's expatriate population is greater than its domestic one. Most Cabo Verdeans have both African and Portuguese antecedents. ", 16.00, 24.00, 4033);

INSERT INTO Country VALUES ("Cambodia", "Most Cambodians consider themselves to be Khmers, descendants of the Angkor Empire that extended over much of Southeast Asia and reached its zenith between the 10th and 13th centuries. Attacks by the Thai and Cham (from present-day Vietnam) weakened the empire, ushering in a long period of decline. The king placed the country under French protection in 1863, and it became part of French Indochina in 1887. Following Japanese occupation in World War II, Cambodia gained full independence from France in 1953. In April 1975, after a five-year struggle, communist Khmer Rouge forces captured Phnom Penh and evacuated all cities and towns. At least 1.5 million Cambodians died from execution, forced hardships, or starvation during the Khmer Rouge regime under POL POT. A December 1978 Vietnamese invasion drove the Khmer Rouge into the countryside, began a 10-year Vietnamese occupation, and touched off almost 13 years of civil war. The 1991 Paris Peace Accords mandated democratic elections and a ceasefire, which was not fully respected by the Khmer Rouge. UN-sponsored elections in 1993 helped restore some semblance of normalcy under a coalition government. Factional fighting in 1997 ended the first coalition government, but a second round of national elections in 1998 led to the formation of another coalition government and renewed political stability. The remaining elements of the Khmer Rouge surrendered in early 1999. Some of the surviving Khmer Rouge leaders have been tried or are awaiting trial for crimes against humanity by a hybrid UN-Cambodian tribunal supported by international assistance. Elections in July 2003 were relatively peaceful, but it took one year of negotiations between contending political parties before a coalition government was formed. In October 2004, King Norodom SIHANOUK abdicated the throne and his son, Prince Norodom SIHAMONI, was selected to succeed him. Local elections were held in Cambodia in April 2007, with little of the pre-election violence that preceded prior elections. National elections in July 2008 were relatively peaceful, as were commune council elections in June 2012. ", 13.00, 105.00, 181035);

INSERT INTO Country VALUES ("Cameroon", "French Cameroon became independent in 1960 as the Republic of Cameroon. The following year the southern portion of neighboring British Cameroon voted to merge with the new country to form the Federal Republic of Cameroon. In 1972, a new constitution replaced the federation with a unitary state, the United Republic of Cameroon. The country has generally enjoyed stability, which has permitted the development of agriculture, roads, and railways, as well as a petroleum industry. Despite slow movement toward democratic reform, political power remains firmly in the hands of President Paul BIYA. ", 6.00, 12.00, 475440);

INSERT INTO Country VALUES ("Canada", "A land of vast distances and rich natural resources, Canada became a self-governing dominion in 1867 while retaining ties to the British crown. Economically and technologically, the nation has developed in parallel with the US, its neighbor to the south across the world's longest unfortified border. Canada faces the political challenges of meeting public demands for quality improvements in health care, education, social services, and economic competitiveness, as well as responding to the particular concerns of predominantly francophone Quebec. Canada also aims to develop its diverse energy resources while maintaining its commitment to the environment. ", 60.00, 95.00, 9984670);

INSERT INTO Country VALUES ("Cayman Islands", "The Cayman Islands were colonized from Jamaica by the British during the 18th and 19th centuries and were administered by Jamaica after 1863. In 1959, the islands became a territory within the Federation of the West Indies. When the Federation dissolved in 1962, the Cayman Islands chose to remain a British dependency. ", 19.30, 80.30, 264);

INSERT INTO Country VALUES ("Central African Republic", "The former French colony of Ubangi-Shari became the Central African Republic upon independence in 1960. After three tumultuous decades of misrule - mostly by military governments - civilian rule was established in 1993 and lasted for one decade. In March, 2003 President Ange-Felix PATASSE was deposed in a military coup led by General Francois BOZIZE, who established a transitional government. Elections held in 2005 affirmed General BOZIZE as president; he was reelected in 2011 in voting widely viewed as flawed. The government still does not fully control the countryside, where pockets of lawlessness persist. The militant group the Lord's Resistance Army continues to destabilize southeastern Central African Republic, and several rebel groups joined together in early December 2012 to launch a series of attacks that left them in control of numerous towns in the northern and central parts of the country. The rebels - who are unhappy with BOZIZE's government - participated in peace talks in early January 2013 which resulted in a coalition government including the rebellion's leadership. In March 2013, the coalition government dissolved, rebels seized the capital, and President BOZIZE fled the country. Rebel leader Michel DJOTODIA assumed the presidency, reappointed Nicolas TIANGAYE as Prime Minister, and established a transitional government on 31 March. On 13 April 2013, the National Transitional Council affirmed DJOTODIA as President. ", 7.00, 21.00, 622984);

INSERT INTO Country VALUES ("Chad", "Chad, part of France's African holdings until 1960, endured three decades of civil warfare, as well as invasions by Libya, before a semblance of peace was finally restored in 1990. The government eventually drafted a democratic constitution and held flawed presidential elections in 1996 and 2001. In 1998, a rebellion broke out in northern Chad, which has sporadically flared up despite several peace agreements between the government and the insurgents. In 2005, new rebel groups emerged in western Sudan and made probing attacks into eastern Chad despite signing peace agreements in December 2006 and October 2007. In June 2005, President Idriss DEBY held a referendum successfully removing constitutional term limits and won another controversial election in 2006. Sporadic rebel campaigns continued throughout 2006 and 2007. The capital experienced a significant insurrection in early 2008, but has had no significant rebel threats since then, in part due to Chad's 2010 rapprochement with Sudan, which previously used Chadian rebels as proxies. DEBY in 2011 was reelected to his fourth term in an election that international observers described as proceeding without incident. Power remains in the hands of an ethnic minority. In January 2014, Chad began a two year rotation on the UN Security Council. ", 15.00, 19.00, 1284000);

INSERT INTO Country VALUES ("Chile", "Prior to the arrival of the Spanish in the 16th century, the Inca ruled northern Chile while the Mapuche inhabited central and southern Chile. Although Chile declared its independence in 1810, decisive victory over the Spanish was not achieved until 1818. In the War of the Pacific (1879-83), Chile defeated Peru and Bolivia and won its present northern regions. It was not until the 1880s that the Mapuche were brought under central government control. After a series of elected governments, the three-year-old Marxist government of Salvador ALLENDE was overthrown in 1973 by a military coup led by Augusto PINOCHET, who ruled until a freely elected president was inaugurated in 1990. Sound economic policies, maintained consistently since the 1980s, contributed to steady growth, reduced poverty rates by over half, and helped secure the country's commitment to democratic and representative government. Chile has increasingly assumed regional and international leadership roles befitting its status as a stable, democratic nation. In January 2014, Chile assumed a nonpermanent seat on the UN Security Council for the 2014-15 term. ", 30.00, 71.00, 756102);

INSERT INTO Country VALUES ("China", "For centuries China stood as a leading civilization, outpacing the rest of the world in the arts and sciences, but in the 19th and early 20th centuries, the country was beset by civil unrest, major famines, military defeats, and foreign occupation. After World War II, the communists under MAO Zedong established an autocratic socialist system that, while ensuring China's sovereignty, imposed strict controls over everyday life and cost the lives of tens of millions of people. After 1978, MAO's successor DENG Xiaoping and other leaders focused on market-oriented economic development and by 2000 output had quadrupled. For much of the population, living standards have improved dramatically and the room for personal choice has expanded, yet political controls remain tight. Since the early 1990s, China has increased its global outreach and participation in international organizations. ", 35.00, 105.00, 9596960);

INSERT INTO Country VALUES ("Christmas Island", "Named in 1643 for the day of its discovery, the island was annexed and settlement began by the UK in 1888 with the discovery of the island's phosphate deposits. Following the Second World War, Christmas Island came under the jurisdiction of the new British Colony of Singapore. The island existed as a separate Crown colony from 1 January 1958 to 1 October 1958 when its transfer to Australian jurisdiction was finalized. That date is still celebrated on the first Monday in October as Territory Day. Almost two-thirds of the island has been declared a national park. ", 10.30, 105.40, 135);

INSERT INTO Country VALUES ("Clipperton Island", "This isolated atoll was named for John CLIPPERTON, a pirate who was rumored to have made it his hideout early in the 18th century. Annexed by France in 1855 and claimed by the United States, it was seized by Mexico in 1897. Arbitration eventually awarded the island to France in 1931, which took possession in 1935. ", 10.17, 109.13, 6);

INSERT INTO Country VALUES ("Cocos (Keeling) Islands", "There are 27 coral islands in the group. Captain William KEELING discovered the islands in 1609, but they remained uninhabited until the 19th century. From the 1820s to 1978, members of the CLUNIE-ROSS family controlled the islands and the copra produced from local coconuts. Annexed by the UK in 1857, the Cocos Islands were transferred to the Australian Government in 1955. Apart from North Keeling Island, which lies 30 kilometers north of the main group, the islands form a horseshoe-shaped atoll surrounding a lagoon. North Keeling Island was declared a national park in 1995 and is administered by Parks Australia. The population on the two inhabited islands generally is split between the ethnic Europeans on West Island and the ethnic Malays on Home Island. ", 12.30, 96.50, 14);

INSERT INTO Country VALUES ("Colombia", "Colombia was one of the three countries that emerged from the collapse of Gran Colombia in 1830 (the others are Ecuador and Venezuela). A nearly five-decade long conflict between government forces and anti-government insurgent groups, principally the Revolutionary Armed Forces of Colombia (FARC) heavily funded by the drug trade, escalated during the 1990s. More than 31,000 former paramilitaries had demobilized by the end of 2006 and the United Self Defense Forces of Colombia as a formal organization had ceased to function. In the wake of the paramilitary demobilization, emerging criminal groups arose, whose members include some former paramilitaries. The insurgents lack the military or popular support necessary to overthrow the government, but continue attacks against civilians. Large areas of the countryside are under guerrilla influence or are contested by security forces. In November 2012, the Colombian Government started formal peace negotiations with the FARC aimed at reaching a definitive bilateral ceasefire and incorporating demobilized FARC members into mainstream society and politics. The Colombian Government has stepped up efforts to reassert government control throughout the country, and now has a presence in every one of its administrative departments. Despite decades of internal conflict and drug related security challenges, Colombia maintains relatively strong democratic institutions characterized by peaceful, transparent elections and the protection of civil liberties. ", 4.00, 72.00, 1138910);

INSERT INTO Country VALUES ("Comoros", "Comoros has endured more than 20 coups or attempted coups since gaining independence from France in 1975. In 1997, the islands of Anjouan and Moheli declared independence from Comoros. In 1999, military chief Col. AZALI seized power of the entire government in a bloodless coup, and helped negotiate the 2000 Fomboni Accords power-sharing agreement in which the federal presidency rotates among the three islands, and each island maintains its local government. AZALI won the 2002 federal presidential election, and each island in the archipelago elected its president. AZALI stepped down in 2006 and President SAMBI was elected to office. In 2007, Mohamed BACAR effected Anjouan's de-facto secession from the Union of Comoros, refusing to step down when Comoros' other islands held legitimate elections in July. The African Union (AU) initially attempted to resolve the political crisis by applying sanctions and a naval blockade to Anjouan, but in March 2008 the AU and Comoran soldiers seized the island. The island's inhabitants generally welcomed the move. In May 2011, Ikililou DHOININE won the presidency in peaceful elections widely deemed to be free and fair. ", 12.10, 44.15, 2235);

INSERT INTO Country VALUES ("Congo, Democratic Republic of the", "Established as a Belgian colony in 1908, the then-Republic of the Congo gained its independence in 1960, but its early years were marred by political and social instability. Col. Joseph MOBUTU seized power and declared himself president in a November 1965 coup. He subsequently changed his name - to MOBUTU Sese Seko - as well as that of the country - to Zaire. MOBUTU retained his position for 32 years through several sham elections, as well as through brutal force. Ethnic strife and civil war, touched off by a massive inflow of refugees in 1994 from fighting in Rwanda and Burundi, led in May 1997 to the toppling of the MOBUTU regime by a rebellion backed by Rwanda and Uganda and fronted by Laurent KABILA. He renamed the country the Democratic Republic of the Congo (DRC), but in August 1998 his regime was itself challenged by a second insurrection again backed by Rwanda and Uganda. Troops from Angola, Chad, Namibia, Sudan, and Zimbabwe intervened to support KABILA's regime. In January 2001, KABILA was assassinated and his son, Joseph KABILA, was named head of state. In October 2002, the new president was successful in negotiating the withdrawal of Rwandan forces occupying the eastern DRC; two months later, the Pretoria Accord was signed by all remaining warring parties to end the fighting and establish a government of national unity. A transitional government was set up in July 2003; it held a successful constitutional referendum in December 2005 and elections for the presidency, National Assembly, and provincial legislatures took place in 2006. In 2009, following a resurgence of conflict in the eastern DRC, the government signed a peace agreement with the National Congress for the Defense of the People (CNDP), a primarily Tutsi rebel group. An attempt to integrate CNDP members into the Congolese military failed, prompting their defection in 2012 and the formation of the M23 armed group - named after the 23 March 2009 peace agreements. Renewed conflict has lead to the displacement of large numbers of people and significant human rights abuses. As of February 2013, peace talks between the Congolese government and the M23 were on-going. In addition, the DRC continues to experience violence committed by other armed groups including the Democratic Forces for the Liberation of Rwanda and Mai Mai groups. In the most recent national elections, held in November 2011, disputed results allowed Joseph KABILA to be reelected to the presidency. ", 0.00, 25.00, 2344858);

INSERT INTO Country VALUES ("Congo, Republic of the", "Upon independence in 1960, the former French region of Middle Congo became the Republic of the Congo. A quarter century of experimentation with Marxism was abandoned in 1990 and a democratically elected government took office in 1992. A brief civil war in 1997 restored former Marxist President Denis SASSOU-Nguesso, and ushered in a period of ethnic and political unrest. Southern-based rebel groups agreed to a final peace accord in March 2003, but the calm is tenuous and refugees continue to present a humanitarian crisis. The Republic of Congo is one of Africa's largest petroleum producers, but with declining production it will need new offshore oil finds to sustain its oil earnings over the long term. ", 1.00, 15.00, 342000);

INSERT INTO Country VALUES ("Cook Islands", "Named after Captain COOK, who sighted them in 1770, the islands became a British protectorate in 1888. By 1900, administrative control was transferred to New Zealand; in 1965, residents chose self-government in free association with New Zealand. The emigration of skilled workers to New Zealand and government deficits are continuing problems. ", 21.14, 159.46, 236);

INSERT INTO Country VALUES ("Costa Rica", "Although explored by the Spanish early in the 16th century, initial attempts at colonizing Costa Rica proved unsuccessful due to a combination of factors, including disease from mosquito-infested swamps, brutal heat, resistance by natives, and pirate raids. It was not until 1563 that a permanent settlement of Cartago was established in the cooler, fertile central highlands. The area remained a colony for some two and a half centuries. In 1821, Costa Rica became one of several Central American provinces that jointly declared their independence from Spain. Two years later it joined the United Provinces of Central America, but this federation disintegrated in 1838, at which time Costa Rica proclaimed its sovereignty and independence. Since the late 19th century, only two brief periods of violence have marred the country's democratic development. In 1949, Costa Rica dissolved its armed forces. Although it still maintains a large agricultural sector, Costa Rica has expanded its economy to include strong technology and tourism industries. The standard of living is relatively high. Land ownership is widespread. ", 10.00, 84.00, 51100);

INSERT INTO Country VALUES ("Cote d'Ivoire", "Close ties to France following independence in 1960, the development of cocoa production for export, and foreign investment all made Cote d'Ivoire one of the most prosperous of the West African states but did not protect it from political turmoil. In December 1999, a military coup - the first ever in Cote d'Ivoire's history - overthrew the government. Junta leader Robert GUEI blatantly rigged elections held in late 2000 and declared himself the winner. Popular protest forced him to step aside and brought Laurent GBAGBO into power. Ivorian dissidents and disaffected members of the military launched a failed coup attempt in September 2002 that developed into a rebellion and then a civil war. The war ended in 2003 with a cease fire that left the country divided with the rebels holding the north, the government the south, and peacekeeping forces a buffer zone between the two. In March 2007, President GBAGBO and former New Forces rebel leader Guillaume SORO signed an agreement in which SORO joined GBAGBO's government as prime minister and the two agreed to reunite the country by dismantling the buffer zone, integrating rebel forces into the national armed forces, and holding elections. Difficulties in preparing electoral registers delayed balloting until 2010. In November 2010, Alassane Dramane OUATTARA won the presidential election over GBAGBO, but GBAGBO refused to hand over power, resulting in a five-month stand-off. In April 2011, after widespread fighting, GBAGBO was formally forced from office by armed OUATTARA supporters with the help of UN and French forces. Several thousand UN peacekeepers and several hundred French troops remain in Cote d'Ivoire to support the transition process. OUATTARA is focused on rebuilding the country's infrastructure and military after the five months of post-electoral fighting and faces ongoing threats from GBAGBO supporters, many of whom have sought shelter in Ghana. GBAGBO is in The Hague awaiting trial for crimes against humanity. ", 8.00, 5.00, 322463);

INSERT INTO Country VALUES ("Croatia", "The lands that today comprise Croatia were part of the Austro-Hungarian Empire until the close of World War I. In 1918, the Croats, Serbs, and Slovenes formed a kingdom known after 1929 as Yugoslavia. Following World War II, Yugoslavia became a federal independent communist state under the strong hand of Marshal TITO. Although Croatia declared its independence from Yugoslavia in 1991, it took four years of sporadic, but often bitter, fighting before occupying Serb armies were mostly cleared from Croatian lands, along with a majority of Croatia's ethnic Serb population. Under UN supervision, the last Serb-held enclave in eastern Slavonia was returned to Croatia in 1998. The country joined NATO in April 2009 and the EU in July 2013. ", 45.10, 15.30, 56594);

INSERT INTO Country VALUES ("Cuba", "The native Amerindian population of Cuba began to decline after the European discovery of the island by Christopher COLUMBUS in 1492 and following its development as a Spanish colony during the next several centuries. Large numbers of African slaves were imported to work the coffee and sugar plantations, and Havana became the launching point for the annual treasure fleets bound for Spain from Mexico and Peru. Spanish rule eventually provoked an independence movement and occasional rebellions that were harshly suppressed. US intervention during the Spanish-American War in 1898 assisted the Cubans in overthrowing Spanish rule. Subsequently, the 1901 Platt Amendment to the Cuban constitution authorized the US to intevene in Cuba in the event of instability. The Treaty of Paris established Cuban independence from the US in 1902 after which the island experienced a string of governments mostly dominated by the military and corrupt politicians. Fidel CASTRO led a rebel army to victory in 1959; his iron rule held the subsequent regime together for nearly five decades. He stepped down as president in February 2008 in favor of his younger brother Raul CASTRO. Cuba's communist revolution, with Soviet support, was exported throughout Latin America and Africa during the 1960s, 1970s, and 1980s. The country faced a severe economic downturn in 1990 following the withdrawal of former Soviet subsidies worth $4-6 billion annually. Cuba at times portrays the US embargo, in place since 1961, as the source if its difficulties. Illicit migration to the US - using homemade rafts, alien smugglers, air flights, or via the US's southwest border - is a continuing problem. The US Coast Guard interdicted 1,357 Cuban nationals attempting to cross the Straits of Florida in 2013. Also in 2013, 14,251 Cuban migrants presented themselves at various land border ports of entry through out the US. ", 21.30, 80.00, 110860);

INSERT INTO Country VALUES ("Curacao", "Originally settled by Arawak Indians, Curacao was seized by the Dutch in 1634 along with the neighboring island of Bonaire. Once the center of the Caribbean slave trade, Curacao was hard hit economically by the abolition of slavery in 1863. Its prosperity (and that of neighboring Aruba) was restored in the early 20th century with the construction of the Isla Refineria to service the newly discovered Venezuelan oil fields. In 1954, Curacao and several other Dutch Caribbean possessions were reorganized as the Netherlands Antilles, part of the Kingdom of the Netherlands. In referenda in 2005 and 2009, the citizens of Curacao voted to become a self-governing country within the Kingdom of the Netherlands. The change in status became effective in October 2010 with the dissolution of the Netherlands Antilles. ", 12.10, 69.00, 444);

INSERT INTO Country VALUES ("Cyprus", "A former British colony, Cyprus became independent in 1960 following years of resistance to British rule. Tensions between the Greek Cypriot majority and Turkish Cypriot minority came to a head in December 1963, when violence broke out in the capital of Nicosia. Despite the deployment of UN peacekeepers in 1964, sporadic intercommunal violence continued forcing most Turkish Cypriots into enclaves throughout the island. In 1974, a Greek Government-sponsored attempt to overthrow the elected president of Cyprus was met by military intervention from Turkey, which soon controlled more than a third of the island. In 1983, the Turkish Cypriot-occupied area declared itself the ''Turkish Republic of Northern Cyprus'' (''TRNC''), but it is recognized only by Turkey. In February 2014, after a hiatus of nearly two years, the leaders of the two communities resumed formal discussions under UN auspices aimed at reuniting the divided island. The talks are ongoing. The entire island entered the EU on 1 May 2004, although the EU acquis - the body of common rights and obligations - applies only to the areas under the internationally recognized government, and is suspended in the areas administered by Turkish Cypriots. However, individual Turkish Cypriots able to document their eligibility for Republic of Cyprus citizenship legally enjoy the same rights accorded to other citizens of European Union states. ", 35.00, 33.00, 9251);

INSERT INTO Country VALUES ("Czech Republic", "At the close of World War I, the Czechs and Slovaks of the former Austro-Hungarian Empire merged to form Czechoslovakia. During the interwar years, having rejected a federal system, the new country's predominantly Czech leaders were frequently preoccupied with meeting the increasingly strident demands of other ethnic minorities within the republic, most notably the Slovaks, the Sudeten Germans, and the Ruthenians (Ukrainians). On the eve of World War II, Nazi Germany occupied the territory that today comprises the Czech Republic and Slovakia became an independent state allied with Germany. After the war, a reunited but truncated Czechoslovakia (less Ruthenia) fell within the Soviet sphere of influence. In 1968, an invasion by Warsaw Pact troops ended the efforts of the country's leaders to liberalize communist rule and create ''socialism with a human face,'' ushering in a period of repression known as ''normalization.'' The peaceful ''Velvet Revolution'' swept the Communist Party from power at the end of 1989 and inaugurated a return to democratic rule and a market economy. On 1 January 1993, the country underwent a nonviolent ''velvet divorce'' into its two national components, the Czech Republic and Slovakia. The Czech Republic joined NATO in 1999 and the European Union in 2004. ", 49.45, 15.30, 78867);

INSERT INTO Country VALUES ("Denmark", "Once the seat of Viking raiders and later a major north European power, Denmark has evolved into a modern, prosperous nation that is participating in the general political and economic integration of Europe. It joined NATO in 1949 and the EEC (now the EU) in 1973. However, the country has opted out of certain elements of the European Union's Maastricht Treaty, including the European Economic and Monetary Union (EMU), European defense cooperation, and issues concerning certain justice and home affairs. ", 56.00, 10.00, 43094);

INSERT INTO Country VALUES ("Dhekelia", "By terms of the 1960 Treaty of Establishment that created the independent Republic of Cyprus, the UK retained full sovereignty and jurisdiction over two areas of almost 254 square kilometers - Akrotiri and Dhekelia. The larger of these is the Dhekelia Sovereign Base Area, which is also referred to as the Eastern Sovereign Base Area. ", 34.59, 33.45, 130);

INSERT INTO Country VALUES ("Djibouti", "The French Territory of the Afars and the Issas became Djibouti in 1977. Hassan Gouled APTIDON installed an authoritarian one-party state and proceeded to serve as president until 1999. Unrest among the Afar minority during the 1990s led to a civil war that ended in 2001 with a peace accord between Afar rebels and the Somali Issa-dominated government. In 1999, Djibouti's first multiparty presidential elections resulted in the election of Ismail Omar GUELLEH as president; he was reelected to a second term in 2005 and extended his tenure in office via a constitutional amendment, which allowed him to begin a third term in 2011. Djibouti occupies a strategic geographic location at the intersection of the Red Sea and the Gulf of Aden and serves as an important shipping portal for goods entering and leaving the east African highlands and transshipments between Europe, the Middle East, and Asia. The government holds longstanding ties to France, which maintains a significant military presence in the country, and has strong ties with the United States. Djibouti hosts several thousand members of US armed services at US-run Camp Lemonnier. ", 11.30, 43.00, 23200);

INSERT INTO Country VALUES ("Dominica", "Dominica was the last of the Caribbean islands to be colonized by Europeans due chiefly to the fierce resistance of the native Caribs. France ceded possession to Great Britain in 1763, which made the island a colony in 1805. In 1980, two years after independence, Dominica's fortunes improved when a corrupt and tyrannical administration was replaced by that of Mary Eugenia CHARLES, the first female prime minister in the Caribbean, who remained in office for 15 years. Some 3,000 Carib Indians still living on Dominica are the only pre-Columbian population remaining in the eastern Caribbean. ", 15.25, 61.20, 751);

INSERT INTO Country VALUES ("Dominican Republic", "The Taino - indigenous inhabitants of Hispaniola prior to the arrival of the Europeans - divided the island into five chiefdoms and territories. Christopher COLUMBUS explored and claimed the island on his first voyage in 1492; it became a springboard for Spanish conquest of the Caribbean and the American mainland. In 1697, Spain recognized French dominion over the western third of the island, which in 1804 became Haiti. The remainder of the island, by then known as Santo Domingo, sought to gain its own independence in 1821 but was conquered and ruled by the Haitians for 22 years; it finally attained independence as the Dominican Republic in 1844. In 1861, the Dominicans voluntarily returned to the Spanish Empire, but two years later they launched a war that restored independence in 1865. A legacy of unsettled, mostly non-representative rule followed, capped by the dictatorship of Rafael Leonidas TRUJILLO from 1930 to 1961. Juan BOSCH was elected president in 1962 but was deposed in a military coup in 1963. In 1965, the United States led an intervention in the midst of a civil war sparked by an uprising to restore BOSCH. In 1966, Joaquin BALAGUER defeated BOSCH in an election to become president. BALAGUER maintained a tight grip on power for most of the next 30 years when international reaction to flawed elections forced him to curtail his term in 1996. Since then, regular competitive elections have been held in which opposition candidates have won the presidency. Former President Leonel FERNANDEZ Reyna (first term 1996-2000) won election to a new term in 2004 following a constitutional amendment allowing presidents to serve more than one term, and was later reelected to a second consecutive term. In 2012, Danilo MEDINA Sanchez was elected president. ", 19.00, 70.40, 48670);

INSERT INTO Country VALUES ("Ecuador", "What is now Ecuador formed part of the northern Inca Empire until the Spanish conquest in 1533. Quito became a seat of Spanish colonial government in 1563 and part of the Viceroyalty of New Granada in 1717. The territories of the Viceroyalty - New Granada (Colombia), Venezuela, and Quito - gained their independence between 1819 and 1822 and formed a federation known as Gran Colombia. When Quito withdrew in 1830, the traditional name was changed in favor of the ''Republic of the Equator.'' Between 1904 and 1942, Ecuador lost territories in a series of conflicts with its neighbors. A border war with Peru that flared in 1995 was resolved in 1999. Although Ecuador marked 30 years of civilian governance in 2004, the period was marred by political instability. Protests in Quito contributed to the mid-term ouster of three of Ecuador's last four democratically elected presidents. In late 2008, voters approved a new constitution, Ecuador's 20th since gaining independence. General elections were held in February 2013, and voters re-elected President Rafael CORREA. ", 2.00, 77.30, 283561);

INSERT INTO Country VALUES ("Egypt", "The regularity and richness of the annual Nile River flood, coupled with semi-isolation provided by deserts to the east and west, allowed for the development of one of the world's great civilizations. A unified kingdom arose circa 3200 B.C., and a series of dynasties ruled in Egypt for the next three millennia. The last native dynasty fell to the Persians in 341 B.C., who in turn were replaced by the Greeks, Romans, and Byzantines. It was the Arabs who introduced Islam and the Arabic language in the 7th century and who ruled for the next six centuries. A local military caste, the Mamluks took control about 1250 and continued to govern after the conquest of Egypt by the Ottoman Turks in 1517. Completion of the Suez Canal in 1869 elevated Egypt as an important world transportation hub. Ostensibly to protect its investments, Britain seized control of Egypt's government in 1882, but nominal allegiance to the Ottoman Empire continued until 1914. Partially independent from the UK in 1922, Egypt acquired full sovereignty from Britain in 1952. The completion of the Aswan High Dam in 1971 and the resultant Lake Nasser have altered the time-honored place of the Nile River in the agriculture and ecology of Egypt. A rapidly growing population (the largest in the Arab world), limited arable land, and dependence on the Nile all continue to overtax resources and stress society. The government has struggled to meet the demands of Egypt's population through economic reform and massive investment in communications and physical infrastructure. Inspired by the 2010 Tunisian revolution, Egyptian opposition groups led demonstrations and labor strikes countrywide, culminating in President Hosni MUBARAK's ouster. Egypt's military assumed national leadership until a new parliament was in place in early 2012; later that same year, Mohammed MORSI won the presidential election. Following often violent protests throughout the spring of 2013 against MORSI's government and the Muslim Brotherhood (MB), and massive anti-government demonstrations, the Egyptian Armed Forces (EAF) intervened and removed MORSI from power in mid-July 2013 and replaced him with interim president Adly MANSOUR. In mid-January 2014, voters approved a new constitution by referendum. Presidential elections to replace MANSOUR are scheduled for late May 2014. According to the constitution and the government's transitional road map, preparations for parliamentary elections will begin by mid-July 2014. ", 27.00, 30.00, 1001450);

INSERT INTO Country VALUES ("El Salvador", "El Salvador achieved independence from Spain in 1821 and from the Central American Federation in 1839. A 12-year civil war, which cost about 75,000 lives, was brought to a close in 1992 when the government and leftist rebels signed a treaty that provided for military and political reforms. ", 13.50, 88.55, 21041);

INSERT INTO Country VALUES ("Equatorial Guinea", "Equatorial Guinea gained independence in 1968 after 190 years of Spanish rule. This tiny country, composed of a mainland portion plus five inhabited islands, is one of the smallest on the African continent. President Teodoro Obiang NGUEMA MBASOGO has ruled the country since 1979 when he seized power in a coup. Although nominally a constitutional democracy since 1991, the 1996, 2002, and 2009 presidential elections - as well as the 1999, 2004, 2008, and 2013 legislative elections - were widely seen as flawed. The president exerts almost total control over the political system and has discouraged political opposition. Equatorial Guinea has experienced rapid economic growth due to the discovery of large offshore oil reserves, and in the last decade has become Sub-Saharan Africa's third largest oil exporter. Despite the country's economic windfall from oil production, resulting in a massive increase in government revenue in recent years, improvements in the population's living standards have been slow to develop. ", 2.00, 10.00, 28051);

INSERT INTO Country VALUES ("Eritrea", "After independence from Italian colonial control in 1941 and 10 years of British administrative control, the UN established Eritrea as an autonomous region within the Ethiopian federation in 1952. Ethiopia's full annexation of Eritrea as a province 10 years later sparked a violent 30-year struggle for independence that ended in 1991 with Eritrean rebels defeating government forces. Eritreans overwhelmingly approved independence in a 1993 referendum. ISAIAS Afworki has been Eritrea's only president since independence; his rule, particularly since 2001, has been highly autocratic and repressive. His government has created a highly militarized society by pursuing an unpopular program of mandatory conscription into national service, sometimes of indefinite length. A two-and-a-half-year border war with Ethiopia that erupted in 1998 ended under UN auspices in December 2000. A UN peacekeeping operation was established that monitored a 25 km-wide Temporary Security Zone. The Eritrea-Ethiopia Boundary Commission (EEBC) created in April 2003 was tasked ''to delimit and demarcate the colonial treaty border based on pertinent colonial treaties (1900, 1902, and 1908) and applicable international law.'' The EEBC on 30 November 2007 remotely demarcated the border, assigning the town of Badme to Eritrea, despite Ethiopia's maintaining forces there from the time of the 1998-2000 war. Eritrea insisted that the UN terminate its peacekeeping mission on 31 July 2008. Eritrea has accepted the EEBC's ''virtual demarcation'' decision and repeatedly called on Ethiopia to remove its troops. Ethiopia has not accepted the demarcation decision, and neither party has entered into meaningful dialogue to resolve the impasse. Eritrea is subject to several UN Security Council Resolutions (from 2009, 2011, and 2012) imposing various military and economic sanctions, in view of evidence that it has supported armed opposition groups in the region. ", 15.00, 39.00, 117600);

INSERT INTO Country VALUES ("Estonia", "After centuries of Danish, Swedish, German, and Russian rule, Estonia attained independence in 1918. Forcibly incorporated into the USSR in 1940 - an action never recognized by the US - it regained its freedom in 1991 with the collapse of the Soviet Union. Since the last Russian troops left in 1994, Estonia has been free to promote economic and political ties with the West. It joined both NATO and the EU in the spring of 2004, formally joined the OECD in late 2010, and adopted the euro as its official currency on 1 January 2011. ", 59.00, 26.00, 45228);

INSERT INTO Country VALUES ("Ethiopia", "Unique among African countries, the ancient Ethiopian monarchy maintained its freedom from colonial rule with the exception of a short-lived Italian occupation from 1936-41. In 1974, a military junta, the Derg, deposed Emperor Haile SELASSIE (who had ruled since 1930) and established a socialist state. Torn by bloody coups, uprisings, wide-scale drought, and massive refugee problems, the regime was finally toppled in 1991 by a coalition of rebel forces, the Ethiopian People's Revolutionary Democratic Front (EPRDF). A constitution was adopted in 1994, and Ethiopia's first multiparty elections were held in 1995. A border war with Eritrea late in the 1990s ended with a peace treaty in December 2000. In November 2007, the Eritrea-Ethiopia Border Commission (EEBC) issued specific coordinates as virtually demarcating the border and pronounced its work finished. Alleging that the EEBC acted beyond its mandate in issuing the coordinates, Ethiopia has not accepted them and has not withdrawn troops from previously contested areas pronounced by the EEBC as belonging to Eritrea. In August 2012, longtime leader Prime Minister MELES Zenawi died in office and was replaced by his Deputy Prime Minister HAILEMARIAM Desalegn, marking the first peaceful transition of power in decades. ", 8.00, 38.00, 1104300);

INSERT INTO Country VALUES ("Falkland Islands (Islas Malvinas)", "Although first sighted by an English navigator in 1592, the first landing (English) did not occur until almost a century later in 1690, and the first settlement (French) was not established until 1764. The colony was turned over to Spain two years later and the islands have since been the subject of a territorial dispute, first between Britain and Spain, then between Britain and Argentina. The UK asserted its claim to the islands by establishing a naval garrison there in 1833. Argentina invaded the islands on 2 April 1982. The British responded with an expeditionary force that landed seven weeks later and after fierce fighting forced an Argentine surrender on 14 June 1982. With hostilities ended and Argentine forces withdrawn, UK administration resumed. In response to renewed calls from Argentina for Britain to relinquish control of the islands, a referendum was held in March 2013, which resulted in 99.8% of the population voting to remain a part of the UK. ", 51.45, 59.00, 12173);

INSERT INTO Country VALUES ("Faroe Islands", "The population of the Faroe Islands is largely descended from Viking settlers who arrived in the 9th century. The islands have been connected politically to Denmark since the 14th century. A high degree of self-government was granted the Faroese in 1948, who have autonomy over most internal affairs while Denmark is responsible for justice, defense, and foreign affairs. The Faroe Islands are not part of the European Union. ", 62.00, 7.00, 1393);

INSERT INTO Country VALUES ("Fiji", "Fiji became independent in 1970 after nearly a century as a British colony. Democratic rule was interrupted by two military coups in 1987 caused by concern over a government perceived as dominated by the Indian community (descendants of contract laborers brought to the islands by the British in the 19th century). The coups and a 1990 constitution that cemented native Melanesian control of Fiji led to heavy Indian emigration; the population loss resulted in economic difficulties, but ensured that Melanesians became the majority. A new constitution enacted in 1997 was more equitable. Free and peaceful elections in 1999 resulted in a government led by an Indo-Fijian, but a civilian-led coup in May 2000 ushered in a prolonged period of political turmoil. Parliamentary elections held in August 2001 provided Fiji with a democratically elected government led by Prime Minister Laisenia QARASE. Re-elected in May 2006, QARASE was ousted in a December 2006 military coup led by Commodore Voreqe BAINIMARAMA, who initially appointed himself acting president but in January 2007 became interim prime minister. Since taking power BAINIMARAMA has neutralized his opponents, crippled Fiji's democratic institutions, and initially refused to hold elections. In 2012, he promised to hold elections in 2014. ", 18.00, 175.00, 18274);

INSERT INTO Country VALUES ("Finland", "Finland was a province and then a grand duchy under Sweden from the 12th to the 19th centuries, and an autonomous grand duchy of Russia after 1809. It gained complete independence in 1917. During World War II, it successfully defended its independence through cooperation with Germany and resisted subsequent invasions by the Soviet Union - albeit with some loss of territory. In the subsequent half century, Finland transformed from a farm/forest economy to a diversified modern industrial economy; per capita income is among the highest in Western Europe. A member of the European Union since 1995, Finland was the only Nordic state to join the euro single currency at its initiation in January 1999. In the 21st century, the key features of Finland's modern welfare state are high quality education, promotion of equality, and a national social welfare system - currently challenged by an aging population and the fluctuations of an export-driven economy. ", 64.00, 26.00, 338145);

INSERT INTO Country VALUES ("France", "France today is one of the most modern countries in the world and is a leader among European nations. It plays an influential global role as a permanent member of the United Nations Security Council, NATO, the G-8, the G-20, the EU and other multilateral organizations. France rejoined NATO's integrated military command structure in 2009, reversing DE GAULLE's 1966 decision to take French forces out of NATO. Since 1958, it has constructed a hybrid presidential-parliamentary governing system resistant to the instabilities experienced in earlier, more purely parliamentary administrations. In recent decades, its reconciliation and cooperation with Germany have proved central to the economic integration of Europe, including the introduction of a common currency, the euro, in January 1999. In the early 21st century, five French overseas entities - French Guiana, Guadeloupe, Martinique, Mayotte, and Reunion - became French regions and were made part of France proper. ", 46.00, 2.00, 643801);

INSERT INTO Country VALUES ("French Polynesia", "The French annexed various Polynesian island groups during the 19th century. In September 1995, France stirred up widespread protests by resuming nuclear testing on the Mururoa atoll after a three-year moratorium. The tests were halted in January 1996. In recent years, French Polynesia's autonomy has been considerably expanded. ", 15.00, 140.00, 4167);

INSERT INTO Country VALUES ("Gabon", "El Hadj Omar BONGO Ondimba - one of the longest-serving heads of state in the world - dominated the country's political scene for four decades (1967-2009) following independence from France in 1960. President BONGO introduced a nominal multiparty system and a new constitution in the early 1990s. However, allegations of electoral fraud during local elections in December 2002 and the presidential elections in 2005 exposed the weaknesses of formal political structures in Gabon. Following President BONGO's death in 2009, new elections brought Ali BONGO Ondimba, son of the former president, to power. Despite constrained political conditions, Gabon's small population, abundant natural resources, and considerable foreign support have helped make it one of the more stable African countries. ", 1.00, 11.45, 267667);

INSERT INTO Country VALUES ("Gambia, The", "The Gambia gained its independence from the UK in 1965. Geographically surrounded by Senegal, it formed a short-lived federation of Senegambia between 1982 and 1989. In 1991 the two nations signed a friendship and cooperation treaty, but tensions have flared up intermittently since then. Yahya JAMMEH led a military coup in 1994 that overthrew the president and banned political activity. A new constitution and presidential elections in 1996, followed by parliamentary balloting in 1997, completed a nominal return to civilian rule. JAMMEH has been elected president in all subsequent elections including most recently in late 2011. ", 13.28, 16.34, 11295);

INSERT INTO Country VALUES ("Gaza Strip", "Inhabited since at least the 15th century B.C., Gaza has been dominated by many different peoples and empires throughout its history; it was incorporated into the Ottoman Empire in the early 16th century. Gaza fell to British forces during World War I, becoming a part of the British Mandate of Palestine. Following the 1948 Arab-Israeli War, Egypt administered the newly formed Gaza Strip; it was captured by Israel in the Six-Day War in 1967. Under a series of agreements signed between 1994 and 1999, Israel transferred to the Palestinian Authority (PA) security and civilian responsibility for many Palestinian-populated areas of the Gaza Strip as well as the West Bank. Negotiations to determine the permanent status of the West Bank and Gaza Strip stalled after the outbreak of an intifada in mid- 2000. In early 2003, the ''Quartet'' of the US, EU, UN, and Russia, presented a roadmap to a final peace settlement by 2005, calling for two states - Israel and a democratic Palestine. Following Palestinian leader Yasir ARAFAT's death in late 2004 and the subsequent election of Mahmud ABBAS (head of the Fatah political party) as the PA president, Israel and the PA agreed to move the peace process forward. Israel in late 2005 unilaterally withdrew all of its settlers and soldiers and dismantled its military facilities in the Gaza Strip, but continues to control maritime, airspace, and other access. In early 2006, the Islamic Resistance Movement, HAMAS, won the Palestinian Legislative Council election and took control of the PA government. Attempts to form a unity government between Fatah and HAMAS failed, and violent clashes between Fatah and HAMAS supporters ensued, culminating in HAMAS's violent seizure of all military and governmental institutions in the Gaza Strip in June 2007. Fatah and HAMAS in early 2011 agreed to reunify the Gaza Strip and West Bank, but the factions have struggled to implement details on governance and security. Brief periods of increased violence between Israel and Palestinian militants in the Gaza Strip in 2007-08 and again in 2012, both led to Egyptian-brokered truces. The status quo remains with HAMAS in control of the Gaza Strip and the PA governing the West Bank. ", 31.25, 34.20, 360);

INSERT INTO Country VALUES ("Georgia", "The region of present day Georgia contained the ancient kingdoms of Colchis and Kartli-Iberia. The area came under Roman influence in the first centuries A.D., and Christianity became the state religion in the 330s. Domination by Persians, Arabs, and Turks was followed by a Georgian golden age (11th-13th centuries) that was cut short by the Mongol invasion of 1236. Subsequently, the Ottoman and Persian empires competed for influence in the region. Georgia was absorbed into the Russian Empire in the 19th century. Independent for three years (1918-1921) following the Russian revolution, it was forcibly incorporated into the USSR in 1921 and regained its independence when the Soviet Union dissolved in 1991. Mounting public discontent over rampant corruption and ineffective government services, followed by an attempt by the incumbent Georgian Government to manipulate national legislative elections in November 2003 touched off widespread protests that led to the resignation of Eduard SHEVARDNADZE, president since 1995. In the aftermath of that popular movement, which became known as the ''Rose Revolution,'' new elections in early 2004 swept Mikheil SAAKASHVILI into power along with his United National Movement (UNM) party. Progress on market reforms and democratization has been made in the years since independence, but this progress has been complicated by Russian assistance and support to the separatist regions of Abkhazia and South Ossetia. Periodic flare-ups in tension and violence culminated in a five-day conflict in August 2008 between Russia and Georgia, including the invasion of large portions of undisputed Georgian territory. Russian troops pledged to pull back from most occupied Georgian territory, but in late August 2008 Russia unilaterally recognized the independence of Abkhazia and South Ossetia, and Russian military forces remain in those regions. Billionaire philanthropist Bidzina IVANISHVILI's unexpected entry into politics in October 2011 brought the divided opposition together under his Georgian Dream coalition, which won a majority of seats in the October 2012 parliamentary election and removed UNM from power. Conceding defeat, SAAKASHVILI named IVANISHVILI as prime minister and allowed Georgian Dream to create a new government. Georgian Dream's Giorgi MARGVELASHVILI was inaugurated as president on 17 November 2013, ending a tense year of power-sharing between SAAKASHVILI and IVANISHVILI. IVANISHVILI voluntarily resigned from office after the presidential succession, and Georgia's legislature on 20 November 2013 confirmed Irakli GARIBASHVILI as his replacement. Georgia's recent elections represent unique examples of a former Soviet state that emerged to conduct democratic and peaceful government transitions of power. Popular and government support for integration with the West is high in Georgia. Joining the EU and NATO are among the country's top foreign policy goals. ", 42.00, 43.30, 69700);

INSERT INTO Country VALUES ("Germany", "As Europe's largest economy and second most populous nation (after Russia), Germany is a key member of the continent's economic, political, and defense organizations. European power struggles immersed Germany in two devastating World Wars in the first half of the 20th century and left the country occupied by the victorious Allied powers of the US, UK, France, and the Soviet Union in 1945. With the advent of the Cold War, two German states were formed in 1949: the western Federal Republic of Germany (FRG) and the eastern German Democratic Republic (GDR). The democratic FRG embedded itself in key Western economic and security organizations, the EC, which became the EU, and NATO, while the communist GDR was on the front line of the Soviet-led Warsaw Pact. The decline of the USSR and the end of the Cold War allowed for German unification in 1990. Since then, Germany has expended considerable funds to bring Eastern productivity and wages up to Western standards. In January 1999, Germany and 10 other EU countries introduced a common European exchange currency, the euro. ", 51.00, 9.00, 357022);

INSERT INTO Country VALUES ("Ghana", "Formed from the merger of the British colony of the Gold Coast and the Togoland trust territory, Ghana in 1957 became the first sub-Saharan country in colonial Africa to gain its independence. Ghana endured a long series of coups before Lt. Jerry RAWLINGS took power in 1981 and banned political parties. After approving a new constitution and restoring multiparty politics in 1992, RAWLINGS won presidential elections in 1992 and 1996 but was constitutionally prevented from running for a third term in 2000. John KUFUOR succeeded him and was reelected in 2004. John Atta MILLS won the 2008 presidential election and took over as head of state, but he died in July 2012 and was constitutionally succeeded by his vice president John Dramani MAHAMA, who subsequently won the December 2012 presidential election. ", 8.00, 2.00, 238533);

INSERT INTO Country VALUES ("Gibraltar", "Strategically important, Gibraltar was reluctantly ceded to Great Britain by Spain in the 1713 Treaty of Utrecht; the British garrison was formally declared a colony in 1830. In a referendum held in 1967, Gibraltarians voted overwhelmingly to remain a British dependency. The subsequent granting of autonomy in 1969 by the UK led to Spain closing the border and severing all communication links. Between 1997 and 2002, the UK and Spain held a series of talks on establishing temporary joint sovereignty over Gibraltar. In response to these talks, the Gibraltar Government called a referendum in late 2002 in which the majority of citizens voted overwhelmingly against any sharing of sovereignty with Spain. Since late 2004, Spain, the UK, and Gibraltar have held tripartite talks with the aim of cooperatively resolving problems that affect the local population, and work continues on cooperation agreements in areas such as taxation and financial services; communications and maritime security; policy, legal and customs services; environmental protection; and education and visa services. Throughout 2009, a dispute over Gibraltar's claim to territorial waters extending out three miles gave rise to periodic non-violent maritime confrontations between Spanish and UK naval patrols and in 2013, the British reported a record number of entries by Spanish vessels into waters claimed by Gibraltar following a dispute over Gibraltar's creation of an artificial reef in those waters. A new noncolonial constitution came into effect in 2007, and the European Court of First Instance recognized Gibraltar's right to regulate its own tax regime in December 2008. The UK retains responsibility for defense, foreign relations, internal security, and financial stability. ", 36.08, 5.21, 6);

INSERT INTO Country VALUES ("Greece", "Greece achieved independence from the Ottoman Empire in 1830. During the second half of the 19th century and the first half of the 20th century, it gradually added neighboring islands and territories, most with Greek-speaking populations. In World War II, Greece was first invaded by Italy (1940) and subsequently occupied by Germany (1941-44); fighting endured in a protracted civil war between supporters of the king and other anti-communist and communist rebels. Following the latter's defeat in 1949, Greece joined NATO in 1952. In 1967, a group of military officers seized power, establishing a military dictatorship that suspended many political liberties and forced the king to flee the country. In 1974, democratic elections and a referendum created a parliamentary republic and abolished the monarchy. In 1981, Greece joined the EC (now the EU); it became the 12th member of the European Economic and Monetary Union in 2001. In 2010, the prospect of a Greek default on its euro-denominated debt created severe strains within the EMU and raised the question of whether a member country might voluntarily leave the common currency or be removed. ", 39.00, 22.00, 131957);

INSERT INTO Country VALUES ("Greenland", "Greenland, the world's largest island, is about 81% ice-capped. Vikings reached the island in the 10th century from Iceland; Danish colonization began in the 18th century, and Greenland was made an integral part of Denmark in 1953. It joined the European Community (now the EU) with Denmark in 1973 but withdrew in 1985 over a dispute centered on stringent fishing quotas. Greenland was granted self-government in 1979 by the Danish parliament; the law went into effect the following year. Greenland voted in favor of increased self-rule in November 2008 and acquired greater responsibility for internal affairs when the Act on Greenland Self-Government was signed into law in June 2009. Denmark, however, continues to exercise control over several policy areas on behalf of Greenland including foreign affairs, security, and financial policy in consultation with Greenland's Self-Rule Government. ", 72.00, 40.00, 2166086);

INSERT INTO Country VALUES ("Grenada", "Carib Indians inhabited Grenada when Christopher COLUMBUS discovered the island in 1498, but it remained uncolonized for more than a century. The French settled Grenada in the 17th century, established sugar estates, and imported large numbers of African slaves. Britain took the island in 1762 and vigorously expanded sugar production. In the 19th century, cacao eventually surpassed sugar as the main export crop; in the 20th century, nutmeg became the leading export. In 1967, Britain gave Grenada autonomy over its internal affairs. Full independence was attained in 1974 making Grenada one of the smallest independent countries in the Western Hemisphere. Grenada was seized by a Marxist military council on 19 October 1983. Six days later the island was invaded by US forces and those of six other Caribbean nations, which quickly captured the ringleaders and their hundreds of Cuban advisers. Free elections were reinstituted the following year and have continued since that time. ", 12.07, 61.40, 344);

INSERT INTO Country VALUES ("Guam", "Spain ceded Guam to the US in 1898. Captured by the Japanese in 1941, it was retaken by the US three years later. The military installations on the island are some of the most strategically important US bases in the Pacific. ", 13.28, 144.47, 544);

INSERT INTO Country VALUES ("Guatemala", "The Maya civilization flourished in Guatemala and surrounding regions during the first millennium A.D. After almost three centuries as a Spanish colony, Guatemala won its independence in 1821. During the second half of the 20th century, it experienced a variety of military and civilian governments, as well as a 36-year guerrilla war. In 1996, the government signed a peace agreement formally ending the internal conflict, which had left more than 200,000 people dead and had created, by some estimates, about 1 million refugees. ", 15.30, 90.15, 108889);

INSERT INTO Country VALUES ("Guernsey", "Guernsey and the other Channel Islands represent the last remnants of the medieval Dukedom of Normandy, which held sway in both France and England. The islands were the only British soil occupied by German troops in World War II. Guernsey is a British crown dependency but is not part of the UK or of the European Union. However, the UK Government is constitutionally responsible for its defense and international representation. ", 49.28, 2.35, 78);

INSERT INTO Country VALUES ("Guinea", "Guinea is at a turning point after decades of authoritarian rule since gaining its independence from France in 1958. Guinea held its first free and competitive democratic presidential and legislative elections in 2010 and 2013 respectively. Alpha CONDE was elected to a five year term as president in 2010, and the National Assembly was seated in January 2014. CONDE's cabinet is the first all-civilian government in Guinea. Previously, Sekou TOURE ruled the country as president from independence to his death in 1984. Lansana CONTE came to power in 1984 when the military seized the government after TOURE's death. Gen. CONTE organized and won presidential elections in 1993, 1998, and 2003, though all the polls were rigged. Upon CONTE's death in December 2008, Capt. Moussa Dadis CAMARA led a military coup, seizing power and suspending the constitution. His unwillingness to yield to domestic and international pressure to step down led to heightened political tensions that culminated in September 2009 when presidential guards opened fire on an opposition rally killing more than 150 people, and in early December 2009 when CAMARA was wounded in an assassination attempt and exiled to Burkina Faso. A transitional government led by Gen. Sekouba KONATE paved the way for Guinea's transition to a fledgling democracy. ", 11.00, 10.00, 245857);

INSERT INTO Country VALUES ("Guinea-Bissau", "Since independence from Portugal in 1974, Guinea-Bissau has experienced considerable political and military upheaval. In 1980, a military coup established authoritarian dictator Joao Bernardo 'Nino' VIEIRA as president. Despite setting a path to a market economy and multiparty system, VIEIRA's regime was characterized by the suppression of political opposition and the purging of political rivals. Several coup attempts through the 1980s and early 1990s failed to unseat him. In 1994 VIEIRA was elected president in the country's first free elections. A military mutiny and resulting civil war in 1998 eventually led to VIEIRA's ouster in May 1999. In February 2000, a transitional government turned over power to opposition leader Kumba YALA after he was elected president in transparent polling. In September 2003, after only three years in office, YALA was overthrown in a bloodless military coup, and businessman Henrique ROSA was sworn in as interim president. In 2005, former President VIEIRA was re-elected president pledging to pursue economic development and national reconciliation; he was assassinated in March 2009. Malam Bacai SANHA was elected in an emergency election held in June 2009, but he passed away in January 2012 from an existing illness. A military coup in April 2012 prevented Guinea-Bissau's second-round presidential election - to determine SANHA's successor - from taking place. ", 12.00, 15.00, 36125);

INSERT INTO Country VALUES ("Guyana", "Originally a Dutch colony in the 17th century, by 1815 Guyana had become a British possession. The abolition of slavery led to settlement of urban areas by former slaves and the importation of indentured servants from India to work the sugar plantations. The resulting ethnocultural divide has persisted and has led to turbulent politics. Guyana achieved independence from the UK in 1966, and since then it has been ruled mostly by socialist-oriented governments. In 1992, Cheddi JAGAN was elected president in what is considered the country's first free and fair election since independence. After his death five years later, his wife, Janet JAGAN, became president but resigned in 1999 due to poor health. Her successor, Bharrat JAGDEO, was reelected in 2001 and again in 2006. Donald RAMOTAR was elected president in 2011. ", 5.00, 59.00, 214969);

INSERT INTO Country VALUES ("Haiti", "The native Taino - who inhabited the island of Hispaniola when it was discovered by Christopher COLUMBUS in 1492 - were virtually annihilated by Spanish settlers within 25 years. In the early 17th century, the French established a presence on Hispaniola. In 1697, Spain ceded to the French the western third of the island, which later became Haiti. The French colony, based on forestry and sugar-related industries, became one of the wealthiest in the Caribbean but only through the heavy importation of African slaves and considerable environmental degradation. In the late 18th century, Haiti's nearly half million slaves revolted under Toussaint L'OUVERTURE. After a prolonged struggle, Haiti became the first post-colonial black-led nation in the world, declaring its independence in 1804. Currently the poorest country in the Western Hemisphere, Haiti has experienced political instability for most of its history. After an armed rebellion led to the forced resignation and exile of President Jean-Bertrand ARISTIDE in February 2004, an interim government took office to organize new elections under the auspices of the United Nations. Continued instability and technical delays prompted repeated postponements, but Haiti inaugurated a democratically elected president and parliament in May of 2006. This was followed by contested elections in 2010 that resulted in the election of Haiti's current President, Michel MARTELLY. A massive magnitude 7.0 earthquake struck Haiti in January 2010 with an epicenter about 25 km (15 mi) west of the capital, Port-au-Prince. Estimates are that over 300,000 people were killed and some 1.5 million left homeless. The earthquake was assessed as the worst in this region over the last 200 years. ", 19.00, 72.25, 27750);

INSERT INTO Country VALUES ("Heard Island and McDonald Islands", "The United Kingdom transferred these uninhabited, barren, sub-Antarctic islands to Australia in 1947. Populated by large numbers of seal and bird species, the islands have been designated a nature preserve. ", 53.06, 72.31, 412);

INSERT INTO Country VALUES ("Holy See (Vatican City)", "Popes in their secular role ruled portions of the Italian peninsula for more than a thousand years until the mid 19th century, when many of the Papal States were seized by the newly united Kingdom of Italy. In 1870, the pope's holdings were further circumscribed when Rome itself was annexed. Disputes between a series of ''prisoner'' popes and Italy were resolved in 1929 by three Lateran Treaties, which established the independent state of Vatican City and granted Roman Catholicism special status in Italy. In 1984, a concordat between the Holy See and Italy modified certain of the earlier treaty provisions, including the primacy of Roman Catholicism as the Italian state religion. Present concerns of the Holy See include religious freedom, threats against minority Christian communities in Africa and the Middle East, sexual misconduct by clergy, international development, interreligious dialogue and reconciliation, and the application of church doctrine in an era of rapid change and globalization. About 1.2 billion people worldwide profess Catholicism - the world's largest Christian faith. ", 41.54, 12.27, 0);

INSERT INTO Country VALUES ("Honduras", "Once part of Spain's vast empire in the New World, Honduras became an independent nation in 1821. After two and a half decades of mostly military rule, a freely elected civilian government came to power in 1982. During the 1980s, Honduras proved a haven for anti-Sandinista contras fighting the Marxist Nicaraguan Government and an ally to Salvadoran Government forces fighting leftist guerrillas. The country was devastated by Hurricane Mitch in 1998, which killed about 5,600 people and caused approximately $2 billion in damage. Since then, the economy has slowly rebounded. ", 15.00, 86.30, 112090);

INSERT INTO Country VALUES ("Hong Kong", "Occupied by the UK in 1841, Hong Kong was formally ceded by China the following year; various adjacent lands were added later in the 19th century. Pursuant to an agreement signed by China and the UK on 19 December 1984, Hong Kong became the Hong Kong Special Administrative Region (SAR) of the People's Republic of China on 1 July 1997. In this agreement, China promised that, under its ''one country, two systems'' formula, China's socialist economic system would not be imposed on Hong Kong and that Hong Kong would enjoy a ''high degree of autonomy'' in all matters except foreign and defense affairs for the subsequent 50 years. ", 22.15, 114.10, 1104);

INSERT INTO Country VALUES ("Howland Island", "Discovered by the US early in the 19th century, the island was officially claimed by the US in 1857. Both US and British companies mined for guano until about 1890. Earhart Light is a day beacon near the middle of the west coast that was partially destroyed during World War II, but subsequently rebuilt; it is named in memory of the famed aviatrix Amelia EARHART. The island is administered by the US Department of the Interior as a National Wildlife Refuge. ", 0.48, 176.38, 1);

INSERT INTO Country VALUES ("Hungary", "Hungary became a Christian kingdom in A.D. 1000 and for many centuries served as a bulwark against Ottoman Turkish expansion in Europe. The kingdom eventually became part of the polyglot Austro-Hungarian Empire, which collapsed during World War I. The country fell under communist rule following World War II. In 1956, a revolt and an announced withdrawal from the Warsaw Pact were met with a massive military intervention by Moscow. Under the leadership of Janos KADAR in 1968, Hungary began liberalizing its economy, introducing so-called ''Goulash Communism.'' Hungary held its first multiparty elections in 1990 and initiated a free market economy. It joined NATO in 1999 and the EU five years later. In 2011, Hungary assumed the six-month rotating presidency of the EU for the first time. ", 47.00, 20.00, 93028);

INSERT INTO Country VALUES ("Iceland", "Settled by Norwegian and Celtic (Scottish and Irish) immigrants during the late 9th and 10th centuries A.D., Iceland boasts the world's oldest functioning legislative assembly, the Althing, established in 930. Independent for over 300 years, Iceland was subsequently ruled by Norway and Denmark. Fallout from the Askja volcano of 1875 devastated the Icelandic economy and caused widespread famine. Over the next quarter century, 20% of the island's population emigrated, mostly to Canada and the US. Denmark granted limited home rule in 1874 and complete independence in 1944. The second half of the 20th century saw substantial economic growth driven primarily by the fishing industry. The economy diversified greatly after the country joined the European Economic Area in 1994, but Iceland was especially hard hit by the global financial crisis in the years following 2008. Literacy, longevity, and social cohesion are first rate by world standards. ", 65.00, 18.00, 103000);

INSERT INTO Country VALUES ("India", "The Indus Valley civilization, one of the world's oldest, flourished during the 3rd and 2nd millennia B.C. and extended into northwestern India. Aryan tribes from the northwest infiltrated the Indian subcontinent about 1500 B.C.; their merger with the earlier Dravidian inhabitants created the classical Indian culture. The Maurya Empire of the 4th and 3rd centuries B.C. - which reached its zenith under ASHOKA - united much of South Asia. The Golden Age ushered in by the Gupta dynasty (4th to 6th centuries A.D.) saw a flowering of Indian science, art, and culture. Islam spread across the subcontinent over a period of 700 years. In the 10th and 11th centuries, Turks and Afghans invaded India and established the Delhi Sultanate. In the early 16th century, the Emperor BABUR established the Mughal Dynasty which ruled India for more than three centuries. European explorers began establishing footholds in India during the 16th century. By the 19th century, Great Britain had become the dominant political power on the subcontinent. The British Indian Army played a vital role in both World Wars. Years of nonviolent resistance to British rule, led by Mohandas GANDHI and Jawaharlal NEHRU, eventually resulted in Indian independence, which was granted in 1947. Large-scale communal violence took place before and after the subcontinent partition into two separate states - India and Pakistan. The neighboring nations have fought three wars since independence, the last of which was in 1971 and resulted in East Pakistan becoming the separate nation of Bangladesh. India's nuclear weapons tests in 1998 emboldened Pakistan to conduct its own tests that same year. In November 2008, terrorists originating from Pakistan conducted a series of coordinated attacks in Mumbai, India's financial capital. Despite pressing problems such as significant overpopulation, environmental degradation, extensive poverty, and widespread corruption, economic growth following the launch of economic reforms in 1991 and a massive youthful population are driving India's emergence as a regional and global power. ", 20.00, 77.00, 3287263);

INSERT INTO Country VALUES ("Indonesia", "The Dutch began to colonize Indonesia in the early 17th century; Japan occupied the islands from 1942 to 1945. Indonesia declared its independence shortly before Japan's surrender, but it required four years of sometimes brutal fighting, intermittent negotiations, and UN mediation before the Netherlands agreed to transfer sovereignty in 1949. A period of sometimes unruly parliamentary democracy ended in 1957 when President SOEKARNO declared martial law and instituted ''Guided Democracy.'' After an abortive coup in 1965 by alleged communist sympathizers, SOEKARNO was gradually eased from power. From 1967 until 1988, President SUHARTO ruled Indonesia with his ''New Order'' government. After rioting toppled Suharto in 1998, free and fair legislative elections took place in 1999. Indonesia is now the world's third most populous democracy, the world's largest archipelagic state, and the world's largest Muslim-majority nation. Current issues include: alleviating poverty, improving education, preventing terrorism, consolidating democracy after four decades of authoritarianism, implementing economic and financial reforms, stemming corruption, reforming the criminal justice system, holding the military and police accountable for human rights violations, addressing climate change, and controlling infectious diseases, particularly those of global and regional importance. In 2005, Indonesia reached a historic peace agreement with armed separatists in Aceh, which led to democratic elections in Aceh in December 2006. Indonesia continues to face low intensity armed resistance in Papua by the separatist Free Papua Movement. ", 5.00, 120.00, 1904569);

INSERT INTO Country VALUES ("Iran", "Known as Persia until 1935, Iran became an Islamic republic in 1979 after the ruling monarchy was overthrown and Shah Mohammad Reza PAHLAVI was forced into exile. Conservative clerical forces led by Ayatollah Ruhollah KHOMEINI established a theocratic system of government with ultimate political authority vested in a learned religious scholar referred to commonly as the Supreme Leader who, according to the constitution, is accountable only to the Assembly of Experts - a popularly elected 86-member body of clerics. US-Iranian relations became strained when a group of Iranian students seized the US Embassy in Tehran in November 1979 and held embassy personnel hostages until mid-January 1981. The US cut off diplomatic relations with Iran in April 1980. During the period 1980-88, Iran fought a bloody, indecisive war with Iraq that eventually expanded into the Persian Gulf and led to clashes between US Navy and Iranian military forces. Iran has been designated a state sponsor of terrorism for its activities in Lebanon and elsewhere in the world and remains subject to US, UN, and EU economic sanctions and export controls because of its continued involvement in terrorism and concerns over possible military dimensions of its nuclear program. Following the election of reformer Hojjat ol-Eslam Mohammad KHATAMI as president in 1997 and a reformist Majles (legislature) in 2000, a campaign to foster political reform in response to popular dissatisfaction was initiated. The movement floundered as conservative politicians, supported by the Supreme Leader, unelected institutions of authority like the Council of Guardians, and the security services reversed and blocked reform measures while increasing security repression. Starting with nationwide municipal elections in 2003 and continuing through Majles elections in 2004, conservatives reestablished control over Iran's elected government institutions, which culminated with the August 2005 inauguration of hardliner Mahmud AHMADI-NEJAD as president. His controversial reelection in June 2009 sparked nationwide protests over allegations of electoral fraud. These protests were quickly suppressed, and the political opposition that arouse as a consequence of AHMADI-NEJAD's election was repressed. Deteriorating economic conditions due primarily to government mismanagement and international sanctions prompted at least two major economically based protests in July and October 2012, but Iran's internal security situation remained stable. President AHMADI-NEJAD's independent streak angered regime establishment figures, including the Supreme Leader, leading to conservative opposition to his agenda for the last year of his presidency, and an alienation of his political supporters. In June 2013 Iranians elected a moderate conservative cleric, Dr. Hasan Fereidun RUHANI to the presidency. He is a long-time senior member in the regime, but has made promises of reforming society and Iran's foreign policy. The UN Security Council has passed a number of resolutions calling for Iran to suspend its uranium enrichment and reprocessing activities and comply with its IAEA obligations and responsibilities, but in November 2013 the five permanent members, plus Germany, (P5+1) signed a joint plan with Iran to provide the country with incremental relief from international pressure for positive steps toward transparency of their nuclear program. ", 32.00, 53.00, 1648195);

INSERT INTO Country VALUES ("Iraq", "Formerly part of the Ottoman Empire, Iraq was occupied by Britain during the course of World War I; in 1920, it was declared a League of Nations mandate under UK administration. In stages over the next dozen years, Iraq attained its independence as a kingdom in 1932. A ''republic'' was proclaimed in 1958, but in actuality a series of strongmen ruled the country until 2003. The last was SADDAM Husayn. Territorial disputes with Iran led to an inconclusive and costly eight-year war (1980-88). In August 1990, Iraq seized Kuwait but was expelled by US-led, UN coalition forces during the Gulf War of January-February 1991. Following Kuwait's liberation, the UN Security Council (UNSC) required Iraq to scrap all weapons of mass destruction and long-range missiles and to allow UN verification inspections. Continued Iraqi noncompliance with UNSC resolutions over a period of 12 years led to the US-led invasion of Iraq in March 2003 and the ouster of the SADDAM Husayn regime. US forces remained in Iraq under a UNSC mandate through 2009 and under a bilateral security agreement thereafter, helping to provide security and to train and mentor Iraqi security forces. In October 2005, Iraqis approved a constitution in a national referendum and, pursuant to this document, elected a 275-member Council of Representatives (COR) in December 2005. The COR approved most cabinet ministers in May 2006, marking the transition to Iraq's first constitutional government in nearly a half century. In January 2009 and April 2013, Iraq held elections for provincial councils in all governorates except for the three governorates comprising the Kurdistan Regional Government and Kirkuk Governorate. Iraq held a national legislative election in March 2010 - choosing 325 legislators in an expanded COR - and, after nine months of deadlock the COR approved the new government in December 2010. Nearly nine years after the start of the Second Gulf War in Iraq, US military operations there ended in mid-December 2011. ", 33.00, 44.00, 438317);

INSERT INTO Country VALUES ("Ireland", "Celtic tribes arrived on the island between 600 and 150 B.C. Invasions by Norsemen that began in the late 8th century were finally ended when King Brian BORU defeated the Danes in 1014. Norman invasions began in the 12th century and set off more than seven centuries of Anglo-Irish struggle marked by fierce rebellions and harsh repressions. The Irish famine of the mid-19th century saw the population of the island drop by one third through starvation and emigration. For more than a century after that the population of the island continued to fall only to begin growing again in the 1960s. Over the last 50 years, Ireland's high birthrate has made it demographically one of the youngest populations in the EU. The modern Irish state traces its origins to the failed 1916 Easter Monday Uprising which touched off several years of guerrilla warfare resulting in independence from the UK in 1921 for 26 southern counties; six northern counties remained part of the UK. Unresolved issues in Northern Ireland erupted into years of violence known as the ''Troubles'' that began in the 1960s. The Government of Ireland was part of a process along with the UK and US Governments that helped broker what is known as The Good Friday Agreement in Northern Ireland in 1998. This initiated a new phase of cooperation between Irish and British governments. Ireland was neutral in World War II and continues its policy of military neutrality. Ireland joined the European Community in 1973 and the Eurozone currency union in 1999. The economic boom years of the Celtic Tiger (1995-2007) saw rapid economic growth, which came to an abrupt end in 2008 with the meltdown of the Irish banking system. Today the economy is recovering, fueled by large and growing foreign direct investment, especially from US multi-nationals. ", 53.00, 8.00, 70273);

INSERT INTO Country VALUES ("Isle of Man", "Part of the Norwegian Kingdom of the Hebrides until the 13th century when it was ceded to Scotland, the isle came under the British crown in 1765. Current concerns include reviving the almost extinct Manx Gaelic language. Isle of Man is a British crown dependency but is not part of the UK or of the European Union. However, the UK Government remains constitutionally responsible for its defense and international representation. ", 54.15, 4.30, 572);

INSERT INTO Country VALUES ("Israel", "Following World War II, the British withdrew from their mandate of Palestine, and the UN proposed partitioning the area into Arab and Jewish states, an arrangement rejected by the Arabs. Nonetheless, an Israeli state was declared in 1948 and the Israelis subsequently defeated the Arabs in a series of wars without ending the deep tensions between the two sides. (The territories Israel occupied since the 1967 war are not included in the Israel country profile, unless otherwise noted.) On 25 April 1982, Israel withdrew from the Sinai pursuant to the 1979 Israel-Egypt Peace Treaty. In keeping with the framework established at the Madrid Conference in October 1991, bilateral negotiations were conducted between Israel and Palestinian representatives and Syria to achieve a permanent settlement. Israel and Palestinian officials signed on 13 September 1993 a Declaration of Principles (also known as the ''Oslo Accords''), enshrining the idea of a two-state solution to their conflict and guiding an interim period of Palestinian self-rule. Outstanding territorial and other disputes with Jordan were resolved in the 26 October 1994 Israel-Jordan Treaty of Peace. Progress toward a permanent status agreement with the Palestinians was undermined by Israeli-Palestinian violence between 2001 and February 2005. Israel in 2005 unilaterally disengaged from the Gaza Strip, evacuating settlers and its military while retaining control over most points of entry into the Gaza Strip. The election of HAMAS to head the Palestinian Legislative Council in 2006 froze relations between Israel and the Palestinian Authority (PA). In 2006 Israel engaged in a 34-day conflict with Hizballah in Lebanon in June-August 2006 and a 23-day conflict with HAMAS in the Gaza Strip during December 2008 and January 2009. Direct talks with the Palestinians launched in September 2010 collapsed following the expiration of Israel's 10-month partial settlement construction moratorium in the West Bank. In November 2012, Israel engaged in a seven-day conflict with HAMAS in the Gaza Strip. Prime Minister Binyamin NETANYAHU formed a coalition government in March 2013 following general elections in January 2013. Direct talks with the Palestinians resumed in July 2013 and but were suspended in late April 2014. ", 31.30, 34.45, 20770);

INSERT INTO Country VALUES ("Italy", "Italy became a nation-state in 1861 when the regional states of the peninsula, along with Sardinia and Sicily, were united under King Victor EMMANUEL II. An era of parliamentary government came to a close in the early 1920s when Benito MUSSOLINI established a Fascist dictatorship. His alliance with Nazi Germany led to Italy's defeat in World War II. A democratic republic replaced the monarchy in 1946 and economic revival followed. Italy is a charter member of NATO and the European Economic Community (EEC). It has been at the forefront of European economic and political unification, joining the Economic and Monetary Union in 1999. Persistent problems include sluggish economic growth, high youth and female unemployment, organized crime, corruption, and economic disparities between southern Italy and the more prosperous north. ", 42.50, 12.50, 301340);

INSERT INTO Country VALUES ("Jamaica", "The island - discovered by Christopher COLUMBUS in 1494 - was settled by the Spanish early in the 16th century. The native Taino, who had inhabited Jamaica for centuries, were gradually exterminated and replaced by African slaves. England seized the island in 1655 and established a plantation economy based on sugar, cocoa, and coffee. The abolition of slavery in 1834 freed a quarter million slaves, many of whom became small farmers. Jamaica gradually increased its independence from Britain. In 1958 it joined other British Caribbean colonies in forming the Federation of the West Indies. Jamaica gained full independence when it withdrew from the Federation in 1962. Deteriorating economic conditions during the 1970s led to recurrent violence as rival gangs affiliated with the major political parties evolved into powerful organized crime networks involved in international drug smuggling and money laundering. Violent crime, drug trafficking, and poverty pose significant challenges to the government today. Nonetheless, many rural and resort areas remain relatively safe and contribute substantially to the economy. ", 18.15, 77.30, 10991);

INSERT INTO Country VALUES ("Jan Mayen", "This desolate, arctic, mountainous island was named after a Dutch whaling captain who indisputably discovered it in 1614 (earlier claims are inconclusive). Visited only occasionally by seal hunters and trappers over the following centuries, the island came under Norwegian sovereignty in 1929. The long dormant Beerenberg volcano, the northernmost active volcano on earth, resumed activity in 1970 and the most recent eruption occurred in 1985. ", 71.00, 8.00, 377);

INSERT INTO Country VALUES ("Japan", "In 1603, after decades of civil warfare, the Tokugawa shogunate (a military-led, dynastic government) ushered in a long period of relative political stability and isolation from foreign influence. For more than two centuries this policy enabled Japan to enjoy a flowering of its indigenous culture. Japan opened its ports after signing the Treaty of Kanagawa with the US in 1854 and began to intensively modernize and industrialize. During the late 19th and early 20th centuries, Japan became a regional power that was able to defeat the forces of both China and Russia. It occupied Korea, Formosa (Taiwan), and southern Sakhalin Island. In 1931-32 Japan occupied Manchuria, and in 1937 it launched a full-scale invasion of China. Japan attacked US forces in 1941 - triggering America's entry into World War II - and soon occupied much of East and Southeast Asia. After its defeat in World War II, Japan recovered to become an economic power and an ally of the US. While the emperor retains his throne as a symbol of national unity, elected politicians hold actual decision-making power. Following three decades of unprecedented growth, Japan's economy experienced a major slowdown starting in the 1990s, but the country remains a major economic power. In March 2011, Japan's strongest-ever earthquake, and an accompanying tsunami, devastated the northeast part of Honshu island, killing thousands and damaging several nuclear power plants. The catastrophe hobbled the country's economy and its energy infrastructure, and tested its ability to deal with humanitarian disasters. ", 36.00, 138.00, 377915);

INSERT INTO Country VALUES ("Jarvis Island", "First discovered by the British in 1821, the uninhabited island was annexed by the US in 1858 but abandoned in 1879 after tons of guano deposits had been removed for use in producing fertilizer. The UK annexed the island in 1889 but never carried out plans for further exploitation. The US occupied and reclaimed the island in 1935. Abandoned after World War II, the island is currently a National Wildlife Refuge administered by the US Department of the Interior. ", 0.22, 160.01, 4);

INSERT INTO Country VALUES ("Jersey", "Jersey and the other Channel Islands represent the last remnants of the medieval Dukedom of Normandy that held sway in both France and England. These islands were the only British soil occupied by German troops in World War II. Jersey is a British crown dependency but is not part of the UK or of the European Union. However, the UK Government is constitutionally responsible for its defense and international representation. ", 49.15, 2.10, 116);

INSERT INTO Country VALUES ("Johnston Atoll", "Both the US and the Kingdom of Hawaii annexed Johnston Atoll in 1858, but it was the US that mined the guano deposits until the late 1880s. Johnston Island and Sand Island were designated wildlife refuges in 1926. The US Navy took over the atoll in 1934, and subsequently the US Air Force assumed control in 1948. The site was used for high-altitude nuclear tests in the 1950s and 1960s, and until late in 2000 the atoll was maintained as a storage and disposal site for chemical weapons. Cleanup and closure of the weapons facility ended in May 2005. ", 16.45, 169.31, 2);

INSERT INTO Country VALUES ("Jordan", "Following World War I and the dissolution of the Ottoman Empire, the League of Nations awarded Britain the mandate to govern much of the Middle East. Britain demarcated a semi-autonomous region of Transjordan from Palestine in the early 1920s. The area gained its independence in 1946 and thereafter became The Hashemite Kingdom of Jordan. The country's long-time ruler, King HUSSEIN (1953-99), successfully navigated competing pressures from the major powers (US, USSR, and UK), various Arab states, Israel, and a large internal Palestinian population. Jordan lost the West Bank to Israel in the 1967 Six-Day War. King HUSSEIN in 1988 permanently relinquished Jordanian claims to the West Bank; in 1994 he signed a peace treaty with Israel. King ABDALLAH II, King HUSSEIN's eldest son, assumed the throne following his father's death in 1999. He implemented modest political and economic reforms, but in the wake of the ''Arab Revolution'' across the Middle East, Jordanians continue to press for further political liberalization, government reforms, and economic improvements. In January 2014, Jordan assumed a nonpermanent seat on the UN Security Council for the 2014-15 term. ", 31.00, 36.00, 89342);

INSERT INTO Country VALUES ("Kazakhstan", "Ethnic Kazakhs, a mix of Turkic and Mongol nomadic tribes who migrated to the region by the 13th century, were rarely united as a single nation. The area was conquered by Russia in the 18th century, and Kazakhstan became a Soviet Republic in 1936. During the 1950s and 1960s agricultural ''Virgin Lands'' program, Soviet citizens were encouraged to help cultivate Kazakhstan's northern pastures. This influx of immigrants (mostly Russians, but also some other deported nationalities) skewed the ethnic mixture and enabled non-ethnic Kazakhs to outnumber natives. Non-Muslim ethnic minorities departed Kazakhstan in large numbers from the mid-1990s through the mid-2000s and a national program has repatriated about a million ethnic Kazakhs back to Kazakhstan. These trends have allowed Kazakhs to become the titular majority again. This dramatic demographic shift has also undermined the previous religious diversity and made the country more than 70 percent Muslim. Kazakhstan's economy is larger than those of all the other Central Asian states largely due to the country's vast natural resources. Current issues include: developing a cohesive national identity; managing Islamic revivalism; expanding the development of the country's vast energy resources and exporting them to world markets; diversifying the economy outside the oil, gas, and mining sectors; enhancing Kazakhstan's economic competitiveness; developing a multiparty parliament and advancing political and social reform; and strengthening relations with neighboring states and other foreign powers. ", 48.00, 68.00, 2724900);

INSERT INTO Country VALUES ("Kenya", "Founding president and liberation struggle icon Jomo KENYATTA led Kenya from independence in 1963 until his death in 1978, when President Daniel MOI took power in a constitutional succession. The country was a de facto one-party state from 1969 until 1982 when the ruling Kenya African National Union (KANU) made itself the sole legal party in Kenya. MOI acceded to internal and external pressure for political liberalization in late 1991. The ethnically fractured opposition failed to dislodge KANU from power in elections in 1992 and 1997, which were marred by violence and fraud, but were viewed as having generally reflected the will of the Kenyan people. President MOI stepped down in December 2002 following fair and peaceful elections. Mwai KIBAKI, running as the candidate of the multiethnic, united opposition group, the National Rainbow Coalition (NARC), defeated KANU candidate Uhuru KENYATTA and assumed the presidency following a campaign centered on an anticorruption platform. KIBAKI's NARC coalition splintered in 2005 over a constitutional review process. Government defectors joined with KANU to form a new opposition coalition, the Orange Democratic Movement (ODM), which defeated the government's draft constitution in a popular referendum in November 2005. KIBAKI's reelection in December 2007 brought charges of vote rigging from ODM candidate Raila ODINGA and unleashed two months of violence in which as many as 1,500 people died. African Union-sponsored mediation led by former UN Secretary General Kofi ANNAN in late February 2008 resulted in a power-sharing accord bringing ODINGA into the government in the restored position of prime minister. The power sharing accord included a broad reform agenda, the centerpiece of which was constitutional reform. In August 2010, Kenyans overwhelmingly adopted a new constitution in a national referendum. The new constitution introduced additional checks and balances to executive power and significant devolution of power and resources to 47 newly created counties. It also eliminated the position of prime minister following the first presidential election under the new constitution, which occurred on 4 March 2013. Uhuru KENYATTA, the son of founding president Jomo KENYATTA, won the March elections in the first round by a close margin and was sworn into office on 9 April 2013. ", 1.00, 38.00, 580367);

INSERT INTO Country VALUES ("Kingman Reef", "The US annexed the reef in 1922. Its sheltered lagoon served as a way station for flying boats on Hawaii-to-American Samoa flights during the late 1930s. There are no terrestrial plants on the reef, which is frequently awash, but it does support abundant and diverse marine fauna and flora. In 2001, the waters surrounding the reef out to 12 nm were designated a US National Wildlife Refuge. ", 6.24, 162.22, 1);

INSERT INTO Country VALUES ("Kiribati", "The Gilbert Islands became a British protectorate in 1892 and a colony in 1915; they were captured by the Japanese in the Pacific War in 1941. The islands of Makin and Tarawa were the sites of major US amphibious victories over entrenched Japanese garrisons in 1943. The Gilbert Islands were granted self-rule by the UK in 1971 and complete independence in 1979 under the new name of Kiribati. The US relinquished all claims to the sparsely inhabited Phoenix and Line Island groups in a 1979 treaty of friendship with Kiribati. ", 1.25, 173.00, 811);

INSERT INTO Country VALUES ("Korea, North", "An independent kingdom for much of its long history, Korea was occupied by Japan beginning in 1905 following the Russo-Japanese War. Five years later, Japan formally annexed the entire peninsula. Following World War II, Korea was split with the northern half coming under Soviet-sponsored communist control. After failing in the Korean War (1950-53) to conquer the US-backed Republic of Korea (ROK) in the southern portion by force, North Korea (DPRK), under its founder President KIM Il Sung, adopted a policy of ostensible diplomatic and economic ''self-reliance'' as a check against outside influence. The DPRK demonized the US as the ultimate threat to its social system through state-funded propaganda, and molded political, economic, and military policies around the core ideological objective of eventual unification of Korea under Pyongyang's control. KIM Il Sung's son, KIM Jong Il, was officially designated as his father's successor in 1980, assuming a growing political and managerial role until the elder KIM's death in 1994. KIM Jong Un was publicly unveiled as his father's successor in September 2010. Following KIM Jong Il's death in December 2011, the regime began to take actions to transfer power to KIM Jong Un and KIM has now assumed many his father's former titles and duties. After decades of economic mismanagement and resource misallocation, the DPRK since the mid-1990s has relied heavily on international aid to feed its population. The DPRK began to ease restrictions to allow semi-private markets, starting in 2002, but then sought to roll back the scale of economic reforms in 2005 and 2009. North Korea's history of regional military provocations; proliferation of military-related items; long-range missile development; WMD programs including tests of nuclear devices in 2006, 2009, and 2013; and massive conventional armed forces are of major concern to the international community. The regime in 2013 announced a new policy calling for the simultaneous development of the North's nuclear weapons program and its economy. ", 40.00, 127.00, 120538);

INSERT INTO Country VALUES ("Korea, South", "An independent kingdom for much of its long history, Korea was occupied by Japan beginning in 1905 following the Russo-Japanese War. In 1910, Tokyo formally annexed the entire Peninsula. Korea regained its independence following Japan's surrender to the United States in 1945. After World War II, a democratic-based government (Republic of Korea, ROK) was set up in the southern half of the Korean Peninsula while a communist-style government was installed in the north (Democratic People's Republic of Korea, DPRK). During the Korean War (1950-53), US troops and UN forces fought alongside ROK soldiers to defend South Korea from a DPRK invasion supported by China and the Soviet Union. A 1953 armistice split the peninsula along a demilitarized zone at about the 38th parallel. PARK Chung-hee took over leadership of the country in a 1961 coup. During his regime, from 1961 to 1979, South Korea achieved rapid economic growth, with per capita income rising to roughly 17 times the level of North Korea. South Korea held its first free presidential election under a revised democratic constitution in 1987, with former ROK Army general ROH Tae-woo winning a close race. In 1993, KIM Young-sam (1993-98) became the first civilian president of South Korea's new democratic era. President KIM Dae-jung (1998-2003) won the Nobel Peace Prize in 2000 for his contributions to South Korean democracy and his ''Sunshine'' policy of engagement with North Korea. President PARK Geun-hye, daughter of former ROK President PARK Chung-hee, took office in February 2013 and is South Korea's first female leader. South Korea holds a non-permanent seat (2013-14) on the UN Security Council and will host the 2018 Winter Olympic Games. Serious tensions with North Korea have punctuated inter-Korean relations in recent years, including the North's attacks on a South Korean ship and island in 2010, nuclear and missile tests, and its temporary closure of the inter-Korean Kaesong Industrial Complex in 2013. ", 37.00, 127.30, 99720);

INSERT INTO Country VALUES ("Kosovo", "The central Balkans were part of the Roman and Byzantine Empires before ethnic Serbs migrated to the territories of modern Kosovo in the 7th century. During the medieval period, Kosovo became the center of a Serbian Empire and saw the construction of many important Serb religious sites, including many architecturally significant Serbian Orthodox monasteries. The defeat of Serbian forces at the Battle of Kosovo in 1389 led to five centuries of Ottoman rule during which large numbers of Turks and Albanians moved to Kosovo. By the end of the 19th century, Albanians replaced the Serbs as the dominant ethnic group in Kosovo. Serbia reacquired control over Kosovo from the Ottoman Empire during the First Balkan War of 1912. After World War II, Kosovo became an autonomous province of Serbia in the Socialist Federal Republic of Yugoslavia (S.F.R.Y.) with status almost equivalent to that of a republic under the 1974 S.F.R.Y. constitution. Despite legislative concessions, Albanian nationalism increased in the 1980s, which led to riots and calls for Kosovo's independence. At the same time, Serb nationalist leaders, such as Slobodan MILOSEVIC, exploited Kosovo Serb claims of maltreatment to secure votes from supporters, many of whom viewed Kosovo as their cultural heartland. Under MILOSEVIC's leadership, Serbia instituted a new constitution in 1989 that revoked Kosovo's status as an autonomous province of Serbia. Kosovo's Albanian leaders responded in 1991 by organizing a referendum that declared Kosovo independent. Under MILOSEVIC, Serbia carried out repressive measures against the Kosovar Albanians in the early 1990s as the unofficial Kosovo government, led by Ibrahim RUGOVA, used passive resistance in an attempt to try to gain international assistance and recognition of an independent Kosovo. Albanians dissatisfied with RUGOVA's passive strategy in the 1990s created the Kosovo Liberation Army and launched an insurgency. Starting in 1998, Serbian military, police, and paramilitary forces under MILOSEVIC conducted a brutal counterinsurgency campaign that resulted in massacres and massive expulsions of ethnic Albanians. Approximately 800,000 ethnic Albanians were forced from their homes in Kosovo during this time. International attempts to mediate the conflict failed, and MILOSEVIC's rejection of a proposed settlement led to a three-month NATO military operation against Serbia beginning in March 1999 that forced Serbia to agree to withdraw its military and police forces from Kosovo. UN Security Council Resolution 1244 (1999) placed Kosovo under a transitional administration, the UN Interim Administration Mission in Kosovo (UNMIK), pending a determination of Kosovo's future status. A UN-led process began in late 2005 to determine Kosovo's final status. The negotiations ran in stages between 2006 and 2007, but ended without agreement between Belgrade and Pristina. On 17 February 2008, the Kosovo Assembly declared Kosovo independent. Since then, over 100 countries have recognized Kosovo, and it has joined the International Monetary Fund, World Bank, European Bank for Reconstruction and Development, the Council of Europe Development Bank, and signed a framework agreement with the European Investment Bank (EIB). In October 2008, Serbia sought an advisory opinion from the International Court of Justice (ICJ) on the legality under international law of Kosovo's declaration of independence. The ICJ released the advisory opinion in July 2010 affirming that Kosovo's declaration of independence did not violate general principles of international law, UN Security Council Resolution 1244, or the Constitutive Framework. The opinion was closely tailored to Kosovo's unique history and circumstances. Serbia continues to reject Kosovo's independence, but the two countries reached an agreement to normalize their relations in April 2013 through EU-facilitated talks and are currently engaged in the implementation process. ", 42.35, 21.00, 10887);

INSERT INTO Country VALUES ("Kuwait", "Britain oversaw foreign relations and defense for the ruling Kuwaiti AL-SABAH dynasty from 1899 until independence in 1961. Kuwait was attacked and overrun by Iraq on 2 August 1990. Following several weeks of aerial bombardment, a US-led, UN coalition began a ground assault on 23 February 1991 that liberated Kuwait in four days. Kuwait spent more than $5 billion to repair oil infrastructure damaged during 1990-91. The AL-SABAH family has ruled since returning to power in 1991 and reestablished an elected legislature that in recent years has become increasingly assertive. The country witnessed the historic election in 2009 of four women to its National Assembly. Amid the 2010-11 uprisings and protests across the Arab world, stateless Arabs, known as bidun, staged small protests in February and March 2011 demanding citizenship, jobs, and other benefits available to Kuwaiti nationals. Youth activist groups - supported by opposition legislators - rallied repeatedly in 2011 for the prime minister's dismissal amid allegations of widespread government corruption. Demonstrators forced the prime minister to resign in late 2011. In late 2012, Kuwait witnessed unprecedented protests in response to the Amir's changes to the electoral law by decree reducing the number of votes per person from four to one. The opposition, led by a coalition of Sunni Islamists, tribalists, some liberals, and myriad youth groups, largely boycotted legislative elections in 2012 and 2013 ushering in legislatures more amenable to the government's agenda. Since 2006, the Amir has dissolved the National Assembly on five occasions (the Constitutional Court annulled the Assembly in June 2012 and again in June 2013) and shuffled the cabinet over a dozen times, usually citing political stagnation and gridlock between the legislature and the government. ", 29.30, 45.45, 17818);

INSERT INTO Country VALUES ("Kyrgyzstan", "A Central Asian country of incredible natural beauty and proud nomadic traditions, most of Kyrgyzstan was formally annexed to Russia in 1876. The Kyrgyz staged a major revolt against the Tsarist Empire in 1916 in which almost one-sixth of the Kyrgyz population was killed. Kyrgyzstan became a Soviet republic in 1936 and achieved independence in 1991 when the USSR dissolved. Nationwide demonstrations in the spring of 2005 resulted in the ouster of President Askar AKAEV, who had run the country since 1990. Former prime minister Kurmanbek BAKIEV overwhelmingly won the presidential election in the summer of 2005. Over the next few years, he manipulated the parliament to accrue new powers for the presidency. In July 2009, after months of harassment against his opponents and media critics, BAKIEV won re-election in a presidential campaign that the international community deemed flawed. In April 2010, violent protests in Bishkek led to the collapse of the BAKIEV regime and his eventual fleeing to Minsk, Belarus. His successor, Roza OTUNBAEVA, served as transitional president until Almazbek ATAMBAEV was inaugurated in December 2011, marking the first peaceful transfer of presidential power in independent Kyrgyzstan's history. Continuing concerns include: the trajectory of democratization, endemic corruption, poor interethnic relations, and terrorism. ", 41.00, 75.00, 199951);

INSERT INTO Country VALUES ("Laos", "Modern-day Laos has its roots in the ancient Lao kingdom of Lan Xang, established in the 14th century under King FA NGUM. For 300 years Lan Xang had influence reaching into present-day Cambodia and Thailand, as well as over all of what is now Laos. After centuries of gradual decline, Laos came under the domination of Siam (Thailand) from the late 18th century until the late 19th century when it became part of French Indochina. The Franco-Siamese Treaty of 1907 defined the current Lao border with Thailand. In 1975, the communist Pathet Lao took control of the government ending a six-century-old monarchy and instituting a strict socialist regime closely aligned to Vietnam. A gradual, limited return to private enterprise and the liberalization of foreign investment laws began in 1988. Laos became a member of ASEAN in 1997 and the WTO in 2013. ", 18.00, 105.00, 236800);

INSERT INTO Country VALUES ("Latvia", "The name ''Latvia'' originates from the ancient Latgalians, one of four eastern Baltic tribes that formed the ethnic core of the Latvian people (ca. 8th-12th centuries A.D.). The region subsequently came under the control of Germans, Poles, Swedes, and finally, Russians. A Latvian republic emerged following World War I, but it was annexed by the USSR in 1940 - an action never recognized by the US and many other countries. Latvia reestablished its independence in 1991 following the breakup of the Soviet Union. Although the last Russian troops left in 1994, the status of the Russian minority (some 28% of the population) remains of concern to Moscow. Latvia acceded to both NATO and the EU in the spring of 2004; it joined the eurozone in 2014. ", 57.00, 25.00, 64589);

INSERT INTO Country VALUES ("Lebanon", "Following World War I, France acquired a mandate over the northern portion of the former Ottoman Empire province of Syria. The French demarcated the region of Lebanon in 1920 and granted this area independence in 1943. Since independence the country has been marked by periods of political turmoil interspersed with prosperity built on its position as a regional center for finance and trade. The country's 1975-90 civil war that resulted in an estimated 120,000 fatalities, was followed by years of social and political instability. Sectarianism is a key element of Lebanese political life. Neighboring Syria has long influenced Lebanon's foreign policy and internal policies, and its military occupied Lebanon from 1976 until 2005. The Lebanon-based Hizballah militia and Israel continued attacks and counterattacks against each other after Syria's withdrawal, and fought a brief war in 2006. Lebanon's borders with Syria and Israel remain unresolved. ", 33.50, 35.50, 10400);

INSERT INTO Country VALUES ("Lesotho", "Basutoland was renamed the Kingdom of Lesotho upon independence from the UK in 1966. The Basuto National Party ruled the country during its first two decades. King MOSHOESHOE was exiled in 1990, but returned to Lesotho in 1992 and was reinstated in 1995 and subsequently succeeded by his son, King LETSIE III, in 1996. Constitutional government was restored in 1993 after seven years of military rule. In 1998, violent protests and a military mutiny following a contentious election prompted a brief but bloody intervention by South African and Batswana military forces under the aegis of the Southern African Development Community. Subsequent constitutional reforms restored relative political stability. Peaceful parliamentary elections were held in 2002, but the National Assembly elections of February 2007 were hotly contested and aggrieved parties disputed how the electoral law was applied to award proportional seats in the Assembly. In May 2012, competitive elections involving 18 parties saw Prime Minister Motsoahae Thomas THABANE form a coalition government - the first in the country's history - that ousted the 14-year incumbent, Pakalitha MOSISILI, who peacefully transferred power the following month. ", 29.30, 28.30, 30355);

INSERT INTO Country VALUES ("Liberia", "Settlement of freed slaves from the US in what is today Liberia began in 1822; by 1847, the Americo-Liberians were able to establish a republic. William TUBMAN, president from 1944-71, did much to promote foreign investment and to bridge the economic, social, and political gaps between the descendants of the original settlers and the inhabitants of the interior. In 1980, a military coup led by Samuel DOE ushered in a decade of authoritarian rule. In December 1989, Charles TAYLOR launched a rebellion against DOE's regime that led to a prolonged civil war in which DOE was killed. A period of relative peace in 1997 allowed for elections that brought TAYLOR to power, but major fighting resumed in 2000. An August 2003 peace agreement ended the war and prompted the resignation of former president Charles TAYLOR, who faces war crimes charges in The Hague related to his involvement in Sierra Leone's civil war. After two years of rule by a transitional government, democratic elections in late 2005 brought President Ellen JOHNSON SIRLEAF to power. She subsequently won reelection in 2011 in a second round vote that was boycotted by the opposition and remains challenged to build Liberia's economy and reconcile a nation still recovering from 14 years of fighting. The United Nations Security Council in September 2012 passed Resolution 2066 which calls for a reduction of UN troops in Liberia by half by 2015, bringing the troop total down to fewer than 4000, and challenging Liberia's security sector to fill the gaps. ", 6.30, 9.30, 111369);

INSERT INTO Country VALUES ("Libya", "The Italians supplanted the Ottoman Turks in the area around Tripoli in 1911 and did not relinquish their hold until 1943 when defeated in World War II. Libya then passed to UN administration and achieved independence in 1951. Following a 1969 military coup, Col. Muammar al-QADHAFI assumed leadership and began to espouse his political system at home, which was a combination of socialism and Islam. During the 1970s, QADHAFI used oil revenues to promote his ideology outside Libya, supporting subversive and terrorist activities that included the downing of two airliners - one over Scotland, another in Northern Africa - and a discotheque bombing in Berlin. UN sanctions in 1992 isolated QADHAFI politically and economically following the attacks; sanctions were lifted in 2003 following Libyan acceptance of responsibility for the bombings and agreement to claimant compensation. QADHAFI also agreed to end Libya's program to develop weapons of mass destruction, and he made significant strides in normalizing relations with Western nations. Unrest that began in several Middle Eastern and North African countries in late 2010 erupted in Libyan cities in early 2011. QADHAFI's brutal crackdown on protesters spawned a civil war that triggered UN authorization of air and naval intervention by the international community. After months of seesaw fighting between government and opposition forces, the QADHAFI regime was toppled in mid-2011 and replaced by a transitional government. Libya in 2012 formed a new parliament and elected a new prime minister. ", 25.00, 17.00, 1759540);

INSERT INTO Country VALUES ("Liechtenstein", "The Principality of Liechtenstein was established within the Holy Roman Empire in 1719. Occupied by both French and Russian troops during the Napoleonic Wars, it became a sovereign state in 1806 and joined the Germanic Confederation in 1815. Liechtenstein became fully independent in 1866 when the Confederation dissolved. Until the end of World War I, it was closely tied to Austria, but the economic devastation caused by that conflict forced Liechtenstein to enter into a customs and monetary union with Switzerland. Since World War II (in which Liechtenstein remained neutral), the country's low taxes have spurred outstanding economic growth. In 2000, shortcomings in banking regulatory oversight resulted in concerns about the use of financial institutions for money laundering. However, Liechtenstein implemented anti-money laundering legislation and a Mutual Legal Assistance Treaty with the US that went into effect in 2003. ", 47.16, 9.32, 160);

INSERT INTO Country VALUES ("Lithuania", "Lithuanian lands were united under MINDAUGAS in 1236; over the next century, through alliances and conquest, Lithuania extended its territory to include most of present-day Belarus and Ukraine. By the end of the 14th century Lithuania was the largest state in Europe. An alliance with Poland in 1386 led the two countries into a union through the person of a common ruler. In 1569, Lithuania and Poland formally united into a single dual state, the Polish-Lithuanian Commonwealth. This entity survived until 1795 when its remnants were partitioned by surrounding countries. Lithuania regained its independence following World War I but was annexed by the USSR in 1940 - an action never recognized by the US and many other countries. On 11 March 1990, Lithuania became the first of the Soviet republics to declare its independence, but Moscow did not recognize this proclamation until September of 1991 (following the abortive coup in Moscow). The last Russian troops withdrew in 1993. Lithuania subsequently restructured its economy for integration into Western European institutions; it joined both NATO and the EU in the spring of 2004. In January 2014, Lithuania assumed a nonpermanent seat on the UN Security Council for the 2014-15 term. ", 56.00, 24.00, 65300);

INSERT INTO Country VALUES ("Luxembourg", "Founded in 963, Luxembourg became a grand duchy in 1815 and an independent state under the Netherlands. It lost more than half of its territory to Belgium in 1839 but gained a larger measure of autonomy. Full independence was attained in 1867. Overrun by Germany in both world wars, it ended its neutrality in 1948 when it entered into the Benelux Customs Union and when it joined NATO the following year. In 1957, Luxembourg became one of the six founding countries of the European Economic Community (later the European Union), and in 1999 it joined the euro currency area. In January 2013, Luxembourg assumed a nonpermanent seat on the UN Security Council for the 2013-14 term. ", 49.45, 6.10, 2586);

INSERT INTO Country VALUES ("Macau", "Colonized by the Portuguese in the 16th century, Macau was the first European settlement in the Far East. Pursuant to an agreement signed by China and Portugal on 13 April 1987, Macau became the Macau Special Administrative Region (SAR) of the People's Republic of China on 20 December 1999. In this agreement, China promised that, under its ''one country, two systems'' formula, China's political and economic system would not be imposed on Macau, and that Macau would enjoy a ''high degree of autonomy'' in all matters except foreign affairs and defense for the subsequent 50 years. ", 22.10, 113.33, 28);

INSERT INTO Country VALUES ("Macedonia", "Macedonia gained its independence peacefully from Yugoslavia in 1991. Greece's objection to the new state's use of what it considered a Hellenic name and symbols delayed international recognition, which occurred under the provisional designation of ''the Former Yugoslav Republic of Macedonia.'' In 1995, Greece lifted a 20-month trade embargo and the two countries agreed to normalize relations, but the issue of the name remained unresolved and negotiations for a solution are ongoing. Since 2004, the US and over 130 other nations have recognized Macedonia by its constitutional name, Republic of Macedonia. Ethnic Albanian grievances over perceived political and economic inequities escalated into an insurgency in 2001 that eventually led to the internationally brokered Ohrid Framework Agreement, which ended the fighting and established guidelines for constitutional amendments and the creation of new laws that enhanced the rights of minorities. Although Macedonia became an EU candidate in 2005, the country still faces challenges, including fully implementing the Framework Agreement, improving relations with Bulgaria, carrying out democratic reforms, and stimulating economic growth and development. Macedonia's membership in NATO was blocked by Greece at the Alliance's Summit of Bucharest in 2008. ", 41.50, 22.00, 25713);

INSERT INTO Country VALUES ("Madagascar", "Formerly an independent kingdom, Madagascar became a French colony in 1896 but regained independence in 1960. During 1992-93, free presidential and National Assembly elections were held ending 17 years of single-party rule. In 1997, in the second presidential race, Didier RATSIRAKA, the leader during the 1970s and 1980s, was returned to the presidency. The 2001 presidential election was contested between the followers of Didier RATSIRAKA and Marc RAVALOMANANA, nearly causing secession of half of the country. In April 2002, the High Constitutional Court announced RAVALOMANANA the winner. RAVALOMANANA achieved a second term following a landslide victory in the generally free and fair presidential elections of 2006. In early 2009, protests over increasing restrictions on opposition press and activities resulted in RAVALOMANANA handing over power to the military, which then conferred the presidency on the mayor of Antananarivo, Andry RAJOELINA, in what amounted to a coup d'etat. Following a lengthy mediation process led by the Southern African Development Community (SADC), Madagascar held UN-supported presidential and parliamentary elections in 2013. Former de facto finance minister Hery RAJAONARIMAMPIANINA defeated RAVALOMANANA's favored candidate Jean-Louis ROBINSON in a presidential runoff and was inaugurated in January 2014. Most international observers, while noting some irregularities, declared polls to be a credible reflection of the Malagasy public's will. ", 20.00, 47.00, 587041);

INSERT INTO Country VALUES ("Malawi", "Established in 1891, the British protectorate of Nyasaland became the independent nation of Malawi in 1964. After three decades of one-party rule under President Hastings Kamuzu BANDA the country held multiparty elections in 1994, under a provisional constitution that came into full effect the following year. President Bingu wa MUTHARIKA, elected in May 2004 after a failed attempt by the previous president to amend the constitution to permit another term, struggled to assert his authority against his predecessor and subsequently started his own party, the Democratic Progressive Party (DPP) in 2005. MUTHARIKA was reelected to a second term in May 2009. He oversaw some economic improvement in his first term, but was accused of economic mismanagement and poor governance in his second term. He died abruptly in April 2012 and was succeeded by his vice president, Joyce BANDA, who had earlier started her own party, the People's Party (PP). Population growth, increasing pressure on agricultural lands, corruption, and the scourge of HIV/AIDS pose major problems for Malawi. ", 13.30, 34.00, 118484);

INSERT INTO Country VALUES ("Malaysia", "During the late 18th and 19th centuries, Great Britain established colonies and protectorates in the area of current Malaysia; these were occupied by Japan from 1942 to 1945. In 1948, the British-ruled territories on the Malay Peninsula except Singapore formed the Federation of Malaya, which became independent in 1957. Malaysia was formed in 1963 when the former British colonies of Singapore, as well as Sabah and Sarawak on the northern coast of Borneo, joined the Federation. The first several years of the country's independence were marred by a communist insurgency, Indonesian confrontation with Malaysia, Philippine claims to Sabah, and Singapore's withdrawal in 1965. During the 22-year term of Prime Minister MAHATHIR bin Mohamad (1981-2003), Malaysia was successful in diversifying its economy from dependence on exports of raw materials to the development of manufacturing, services, and tourism. Prime Minister Mohamed NAJIB bin Abdul Razak (in office since April 2009) has continued these pro-business policies and has introduced some civil reforms. ", 2.30, 112.30, 329847);

INSERT INTO Country VALUES ("Maldives", "A sultanate since the 12th century, the Maldives became a British protectorate in 1887. It became a republic in 1968, three years after independence. President Maumoon Abdul GAYOOM dominated the islands' political scene for 30 years, elected to six successive terms by single-party referendums. Following political demonstrations in the capital Male in August 2003, the president and his government pledged to embark upon a process of liberalization and democratic reforms, including a more representative political system and expanded political freedoms. Progress was sluggish, however, and many promised reforms were slow to be realized. Nonetheless, political parties were legalized in 2005. In June 2008, a constituent assembly - termed the ''Special Majlis'' - finalized a new constitution, which was ratified by the president in August. The first-ever presidential elections under a multi-candidate, multi-party system were held in October 2008. GAYOOM was defeated in a runoff poll by Mohamed NASHEED, a political activist who had been jailed several years earlier by the former regime. President NASHEED faced a number of challenges including strengthening democracy and combating poverty and drug abuse. In early February 2012, after several weeks of street protests following his sacking of a top judge, NASHEED resigned the presidency and handed over power to Vice President Mohammed WAHEED Hassan Maniku. In mid-2012, a Commission of National Inquiry was set by the government to probe events leading up to NASHEED's resignation. Though the commission found no evidence of a coup, the report recommended the need to strengthen the country's democratic institutions to avert similar events in the future, and to further investigate alleged police misconduct during the crisis. Maldivian officials have played a prominent role in international climate change discussions (due to the islands' low elevation and the threat from sea-level rise) on the UN Human Rights Council and in other international forums, as well as in encouraging regional cooperation, especially between India and Pakistan. ", 3.15, 73.00, 298);

INSERT INTO Country VALUES ("Mali", "The Sudanese Republic and Senegal became independent of France in 1960 as the Mali Federation. When Senegal withdrew after only a few months, what formerly made up the Sudanese Republic was renamed Mali. Rule by dictatorship was brought to a close in 1991 by a military coup that ushered in a period of democratic rule. President Alpha KONARE won Mali's first two democratic presidential elections in 1992 and 1997. In keeping with Mali's two-term constitutional limit, he stepped down in 2002 and was succeeded by Amadou Toumani TOURE, who was elected to a second term in 2007 elections that were widely judged to be free and fair. Malian returnees from Libya in 2011 exacerbated tensions in northern Mali, and Tuareg ethnic militias started a rebellion in January 2012. Low- and mid-level soldiers, frustrated with the poor handling of the rebellion overthrew TOURE on 22 March. Intensive mediation efforts led by the Economic Community of West African States (ECOWAS) returned power to a civilian administration in April with the appointment of interim President Dioncounda TRAORE. The post-coup chaos led to rebels expelling the Malian military from the three northern regions of the country and allowed Islamic militants to set up strongholds. Hundreds of thousands of northern Malians fled the violence to southern Mali and neighboring countries, exacerbating regional food insecurity in host communities. An international military intervention to retake the three northern regions began in January 2013 and within a month most of the north had been retaken. In a democratic presidential election conducted in July and August of 2013, Ibrahim Boubacar KEITA was elected president in the second round. ", 17.00, 4.00, 1240192);

INSERT INTO Country VALUES ("Malta", "Great Britain formally acquired possession of Malta in 1814. The island staunchly supported the UK through both world wars and remained in the Commonwealth when it became independent in 1964; a decade later it declared itself a republic. Since about the mid-1980s, the island has transformed itself into a freight transshipment point, a financial center, and a tourist destination. Malta became an EU member in May 2004 and began using the euro as currency in 2008. ", 35.50, 14.35, 316);

INSERT INTO Country VALUES ("Marshall Islands", "After almost four decades under US administration as the easternmost part of the UN Trust Territory of the Pacific Islands, the Marshall Islands attained independence in 1986 under a Compact of Free Association. Compensation claims continue as a result of US nuclear testing on some of the atolls between 1947 and 1962. The Marshall Islands hosts the US Army Kwajalein Atoll (USAKA) Reagan Missile Test Site, a key installation in the US missile defense network. ", 9.00, 168.00, 181);

INSERT INTO Country VALUES ("Mauritania", "Independent from France in 1960, Mauritania annexed the southern third of the former Spanish Sahara (now Western Sahara) in 1976 but relinquished it after three years of raids by the Polisario guerrilla front seeking independence for the territory. Maaouya Ould Sid Ahmed TAYA seized power in a coup in 1984 and ruled Mauritania with a heavy hand for more than two decades. A series of presidential elections that he held were widely seen as flawed. A bloodless coup in August 2005 deposed President TAYA and ushered in a military council that oversaw a transition to democratic rule. Independent candidate Sidi Ould Cheikh ABDALLAHI was inaugurated in April 2007 as Mauritania's first freely and fairly elected president. His term ended prematurely in August 2008 when a military junta led by General Mohamed Ould Abdel AZIZ deposed him and installed a military council government. AZIZ was subsequently elected president in July 2009 and sworn in the following month. AZIZ sustained injuries from an accidental shooting by his own troops in October 2012 but has continued to maintain his authority. The country continues to experience ethnic tensions among its black population (Afro-Mauritanians) and white and black Moor (Arab-Berber) communities, and confronts a terrorism threat by al-Qa'ida in the Islamic Maghreb (AQIM). ", 20.00, 12.00, 1030700);

INSERT INTO Country VALUES ("Mauritius", "Although known to Arab and Malay sailors as early as the 10th century, Mauritius was first explored by the Portuguese in the 16th century and subsequently settled by the Dutch - who named it in honor of Prince Maurits van NASSAU - in the 17th century. The French assumed control in 1715, developing the island into an important naval base overseeing Indian Ocean trade, and establishing a plantation economy of sugar cane. The British captured the island in 1810, during the Napoleonic Wars. Mauritius remained a strategically important British naval base, and later an air station, playing an important role during World War II for anti-submarine and convoy operations, as well as the collection of signals intelligence. Independence from the UK was attained in 1968. A stable democracy with regular free elections and a positive human rights record, the country has attracted considerable foreign investment and has earned one of Africa's highest per capita incomes. ", 20.17, 57.33, 2040);

INSERT INTO Country VALUES ("Mexico", "The site of several advanced Amerindian civilizations - including the Olmec, Toltec, Teotihuacan, Zapotec, Maya, and Aztec - Mexico was conquered and colonized by Spain in the early 16th century. Administered as the Viceroyalty of New Spain for three centuries, it achieved its independence early in the 19th century. The global financial crisis beginning in late 2008 caused a massive economic downturn the following year, although growth returned quickly in 2010. Ongoing economic and social concerns include low real wages, underemployment for a large segment of the population, inequitable income distribution, and few advancement opportunities for the largely indigenous population in the impoverished southern states. The elections held in 2000 marked the first time since the 1910 Mexican Revolution that an opposition candidate - Vicente FOX of the National Action Party (PAN) - defeated the party in government, the Institutional Revolutionary Party (PRI). He was succeeded in 2006 by another PAN candidate Felipe CALDERON, but Enrique PENA NIETO regained the presidency for the PRI in 2012. Since 2007, Mexico's powerful drug-trafficking organizations have engaged in bloody feuding, resulting in tens of thousands of drug-related homicides. ", 23.00, 102.00, 1964375);

INSERT INTO Country VALUES ("Micronesia, Federated States of", "The Caroline Islands are a widely scattered archipelago in the western Pacific Ocean; they became part of a UN Trust Territory under US administration following World War II. The eastern four island groups adopted a constitution in 1979 and chose to become the Federated States of Micronesia. (The fifth, westernmost island group became Palau.) Independence came in 1986 under a Compact of Free Association with the US, which was amended and renewed in 2004. Present concerns include large-scale unemployment, overfishing, and overdependence on US aid. ", 6.55, 158.15, 702);

INSERT INTO Country VALUES ("Midway Islands", "The US took formal possession of the islands in 1867. The laying of the trans-Pacific cable, which passed through the islands, brought the first residents in 1903. Between 1935 and 1947, Midway was used as a refueling stop for trans-Pacific flights. The US naval victory over a Japanese fleet off Midway in 1942 was one of the turning points of World War II. The islands continued to serve as a naval station until closed in 1993. Today the islands are a US National Wildlife Refuge. From 1996 to 2001 the refuge was open to the public; it is now temporarily closed. ", 28.12, 177.22, 6);

INSERT INTO Country VALUES ("Moldova", "Part of Romania during the interwar period, Moldova was incorporated into the Soviet Union at the close of World War II. Although the country has been independent from the USSR since 1991, Russian forces have remained on Moldovan territory east of the Nistru River supporting the separatist region of Transnistria, composed of a Slavic majority population (mostly Ukrainians and Russians), but with a sizeable ethnic Moldovan minority. One of the poorest nations in Europe, Moldova became the first former Soviet state to elect a communist, Vladimir VORONIN, as its president in 2001. VORONIN served as Moldova's president until he resigned in September 2009, following the opposition's gain of a narrow majority in July parliamentary elections and the Communist Party's (PCRM) subsequent inability to attract the three-fifths of parliamentary votes required to elect a president and, by doing so, put into place a permanent government. Four Moldovan opposition parties formed a new coalition, the Alliance for European Integration (AEI), iterations of which have acted as Moldova's governing coalitions since. Moldova experienced significant political uncertainty between 2009 and early 2012, holding three general elections and numerous presidential ballots in parliament, all of which failed to secure a president. Following November 2010 parliamentary elections, a reconstituted AEI-coalition consisting of three of the four original AEI parties formed a government, and in March 2012 was finally able to elect an independent as president. As of late May 2013, the ruling coalition - comprised of two of the original AEI parties and a splinter group from a third - is called the Pro-European Coalition. In November 2013, the Moldovan Government initialed an Association Agreement with the European Union (EU), advancing the coalition's policy priority of EU integration. ", 47.00, 29.00, 33851);

INSERT INTO Country VALUES ("Monaco", "The Genoese built a fortress on the site of present day Monaco in 1215. The current ruling GRIMALDI family first seized temporary control in 1297, and again in 1331, but were not able to permanently secure their holding until 1419. Economic development was spurred in the late 19th century with a railroad linkup to France and the opening of a casino. Since then, the principality's mild climate, splendid scenery, and gambling facilities have made Monaco world famous as a tourist and recreation center. ", 43.44, 7.24, 2);

INSERT INTO Country VALUES ("Mongolia", "The Mongols gained fame in the 13th century when under Chinggis KHAAN they established a huge Eurasian empire through conquest. After his death the empire was divided into several powerful Mongol states, but these broke apart in the 14th century. The Mongols eventually retired to their original steppe homelands and in the late 17th century came under Chinese rule. Mongolia won its independence in 1921 with Soviet backing and a communist regime was installed in 1924. The modern country of Mongolia, however, represents only part of the Mongols' historical homeland; more ethnic Mongolians live in the Inner Mongolia Autonomous Region in the People's Republic of China than in Mongolia. Following a peaceful democratic revolution, the ex-communist Mongolian People's Revolutionary Party (MPRP) won elections in 1990 and 1992, but was defeated by the Democratic Union Coalition (DUC) in the 1996 parliamentary election. The MPRP won an overwhelming majority in the 2000 parliamentary election, but the party lost seats in the 2004 election and shared power with democratic coalition parties from 2004-08. The MPRP regained a solid majority in the 2008 parliamentary elections but nevertheless formed a coalition government with the Democratic Party that lasted until January 2012. In 2009, current President ELBEGDORJ of the Democratic Party was elected to office and was re-elected for his second term in June 2013. In 2010, the MPRP voted to retake the name of the Mongolian People's Party (MPP), a name it used in the early 1920s. Shortly thereafter, a new party was formed by former president ENKHBAYAR, which adopted the MPRP name. In the 2012 Parliamentary elections, a coalition of four political parties led by the Democratic Party, gained control of the Parliament. ", 46.00, 105.00, 1564116);

INSERT INTO Country VALUES ("Montenegro", "The use of the name Crna Gora or Black Mountain (Montenegro) began in the 13th century in reference to a highland region in the Serbian province of Zeta. The later medieval state of Zeta maintained its existence until 1496 when Montenegro finally fell under Ottoman rule. Over subsequent centuries Montenegro managed to maintain a level of autonomy within the Ottoman Empire. From the 16th to 19th centuries, Montenegro was a theocracy ruled by a series of bishop princes; in 1852, it transformed into a secular principality. Montenegro was recognized as an independent sovereign principality at the Congress of Berlin in 1878. After World War I, during which Montenegro fought on the side of the Allies, Montenegro was absorbed by the Kingdom of Serbs, Croats, and Slovenes, which became the Kingdom of Yugoslavia in 1929; at the conclusion of World War II, it became a constituent republic of the Socialist Federal Republic of Yugoslavia. When the latter dissolved in 1992, Montenegro federated with Serbia, creating the Federal Republic of Yugoslavia and, after 2003, shifting to a looser State Union of Serbia and Montenegro. In May 2006, Montenegro invoked its right under the Constitutional Charter of Serbia and Montenegro to hold a referendum on independence from the state union. The vote for severing ties with Serbia barely exceeded 55% - the threshold set by the EU - allowing Montenegro to formally restore its independence on 3 June 2006. ", 42.30, 19.18, 13812);

INSERT INTO Country VALUES ("Montserrat", "English and Irish colonists from St. Kitts first settled on Montserrat in 1632; the first African slaves arrived three decades later. The British and French fought for possession of the island for most of the 18th century, but it finally was confirmed as a British possession in 1783. The island's sugar plantation economy was converted to small farm landholdings in the mid 19th century. Much of this island was devastated and two-thirds of the population fled abroad because of the eruption of the Soufriere Hills Volcano that began on 18 July 1995. Montserrat has endured volcanic activity since, with the last eruption occurring in July 2003. ", 16.45, 62.12, 102);

INSERT INTO Country VALUES ("Morocco", "In 788, about a century after the Arab conquest of North Africa, a series of Moroccan Muslim dynasties began to rule in Morocco. In the 16th century, the Sa'adi monarchy, particularly under Ahmad al-MANSUR (1578-1603), repelled foreign invaders and inaugurated a golden age. The Alaouite Dynasty, to which the current Moroccan royal family belongs, dates from the 17th century. In 1860, Spain occupied northern Morocco and ushered in a half century of trade rivalry among European powers that saw Morocco's sovereignty steadily erode; in 1912, the French imposed a protectorate over the country. A protracted independence struggle with France ended successfully in 1956. The internationalized city of Tangier and most Spanish possessions were turned over to the new country that same year. Sultan MOHAMMED V, the current monarch's grandfather, organized the new state as a constitutional monarchy and in 1957 assumed the title of king. Although Morocco is not the UN-recognized Administering Power for the Western Sahara, it exercises de facto administrative control over 80% of the territory. The UN since 1991 has monitored a ceasefire between Morocco and the Polisario Front and leads ongoing negotiations over the status of the territory. King MOHAMMED VI in early 2011 responded to the spread of pro-democracy protests in the region by implementing a reform program that included a new constitution, passed by popular referendum in July 2011, under which some new powers were extended to parliament and the prime minister but ultimate authority remains in the hands of the monarch. In November 2012, the Justice and Development Party - a moderate Islamist party - won the largest number of seats in parliamentary elections, becoming the first Islamist party to lead the Moroccan Government. ", 32.00, 5.00, 446550);

INSERT INTO Country VALUES ("Mozambique", "Almost five centuries as a Portuguese colony came to a close with independence in 1975. Large-scale emigration, economic dependence on South Africa, a severe drought, and a prolonged civil war hindered the country's development until the mid 1990s. The ruling Front for the Liberation of Mozambique (Frelimo) party formally abandoned Marxism in 1989, and a new constitution the following year provided for multiparty elections and a free market economy. A UN-negotiated peace agreement between Frelimo and rebel Mozambique National Resistance (Renamo) forces ended the fighting in 1992. In December 2004, Mozambique underwent a delicate transition as Joaquim CHISSANO stepped down after 18 years in office. His elected successor, Armando Emilio GUEBUZA, promised to continue the sound economic policies that have encouraged foreign investment. President GUEBUZA was reelected to a second term in October 2009. However, the elections were flawed by voter fraud, questionable disqualification of candidates, and Frelimo use of government resources during the campaign. As a result, Freedom House removed Mozambique from its list of electoral democracies. ", 18.15, 35.00, 799380);

INSERT INTO Country VALUES ("Namibia", "South Africa occupied the German colony of South-West Africa during World War I and administered it as a mandate until after World War II, when it annexed the territory. In 1966 the Marxist South-West Africa People's Organization (SWAPO) guerrilla group launched a war of independence for the area that became Namibia, but it was not until 1988 that South Africa agreed to end its administration in accordance with a UN peace plan for the entire region. Namibia has been governed by SWAPO since the country won independence in 1990. Hifikepunye POHAMBA was elected president in November 2004 in a landslide victory replacing Sam NUJOMA who led the country during its first 14 years of self rule. POHAMBA was reelected in November 2009. ", 22.00, 17.00, 824292);

INSERT INTO Country VALUES ("Nauru", "The exact origins of the Nauruans are unclear since their language does not resemble any other in the Pacific region. Germany annexed the island in 1888. A German-British consortium began mining the island's phosphate deposits early in the 20th century. Australian forces occupied Nauru in World War I; it subsequently became a League of Nations mandate. After the Second World War - and a brutal occupation by Japan - Nauru became a UN trust territory. It achieved independence in 1968 and joined the UN in 1999 as the world's smallest independent republic. ", 0.32, 166.55, 21);

INSERT INTO Country VALUES ("Navassa Island", "This uninhabited island was claimed by the US in 1857 for its guano. Mining took place between 1865 and 1898. The lighthouse, built in 1917, was shut down in 1996 and administration of Navassa Island transferred from the US Coast Guard to the Department of the Interior. A 1998 scientific expedition to the island described it as a unique preserve of Caribbean biodiversity; the following year it became a National Wildlife Refuge and annual scientific expeditions have continued. ", 18.25, 75.02, 5);

INSERT INTO Country VALUES ("Nepal", "In 1951, the Nepali monarch ended the century-old system of rule by hereditary premiers and instituted a cabinet system of government. Reforms in 1990 established a multiparty democracy within the framework of a constitutional monarchy. An insurgency led by Maoists broke out in 1996. The ensuing 10-year civil war between Maoist and government forces witnessed the dissolution of the cabinet and parliament and assumption of absolute power by the king in 2002. Several weeks of mass protests in April 2006 were followed by several months of peace negotiations between the Maoists and government officials, and culminated in a late 2006 peace accord and the promulgation of an interim constitution. Following a nationwide election in April 2008, the newly formed Constituent Assembly (CA) declared Nepal a federal democratic republic and abolished the monarchy at its first meeting the following month. The CA elected the country's first president in July. Between 2008 and 2011 there were four different coalition governments, led twice by the United Communist Party of Nepal-Maoist, which received a plurality of votes in the 2008 CA election, and twice by the Communist Party of Nepal-United Marxist-Leninist (UML). After the CA failed to draft a constitution by the May 2012 deadline set by the Supreme Court, then Prime Minister Baburam BHATTARAI dissolved the CA. Months of negotiations ensued until March 2013 when the major political parties agreed to create an interim government headed by then Chief Justice Khil Raj REGMI with a mandate to hold elections for a new CA. Elections were held in November 2013, in which and the Nepali Congress won the largest share of the seats in the CA and in February 2014 formed a coalition government with the second place UML and with Nepali Congress President Sushil KOIRALA as prime minister ", 28.00, 84.00, 147181);

INSERT INTO Country VALUES ("Netherlands", "The Dutch United Provinces declared their independence from Spain in 1579; during the 17th century, they became a leading seafaring and commercial power, with settlements and colonies around the world. After a 20-year French occupation, a Kingdom of the Netherlands was formed in 1815. In 1830 Belgium seceded and formed a separate kingdom. The Netherlands remained neutral in World War I, but suffered invasion and occupation by Germany in World War II. A modern, industrialized nation, the Netherlands is also a large exporter of agricultural products. The country was a founding member of NATO and the EEC (now the EU) and participated in the introduction of the euro in 1999. In October 2010, the former Netherlands Antilles was dissolved and the three smallest islands - Bonaire, Sint Eustatius, and Saba - became special municipalities in the Netherlands administrative structure. The larger islands of Sint Maarten and Curacao joined the Netherlands and Aruba as constituent countries forming the Kingdom of the Netherlands. ", 52.30, 5.45, 41543);

INSERT INTO Country VALUES ("New Caledonia", "Settled by both Britain and France during the first half of the 19th century, the island became a French possession in 1853. It served as a penal colony for four decades after 1864. Agitation for independence during the 1980s and early 1990s ended in the 1998 Noumea Accord, which over a period of 15 to 20 years will transfer an increasing amount of governing responsibility from France to New Caledonia. The agreement also commits France to conduct a referendum between 2014 and 2018 to decide whether New Caledonia should assume full sovereignty and independence. ", 21.30, 165.30, 18575);

INSERT INTO Country VALUES ("New Zealand", "The Polynesian Maori reached New Zealand in about A.D. 800. In 1840, their chieftains entered into a compact with Britain, the Treaty of Waitangi, in which they ceded sovereignty to Queen Victoria while retaining territorial rights. That same year, the British began the first organized colonial settlement. A series of land wars between 1843 and 1872 ended with the defeat of the native peoples. The British colony of New Zealand became an independent dominion in 1907 and supported the UK militarily in both world wars. New Zealand's full participation in a number of defense alliances lapsed by the 1980s. In recent years, the government has sought to address longstanding Maori grievances. ", 41.00, 174.00, 267710);

INSERT INTO Country VALUES ("Nicaragua", "The Pacific coast of Nicaragua was settled as a Spanish colony from Panama in the early 16th century. Independence from Spain was declared in 1821 and the country became an independent republic in 1838. Britain occupied the Caribbean Coast in the first half of the 19th century, but gradually ceded control of the region in subsequent decades. Violent opposition to governmental manipulation and corruption spread to all classes by 1978 and resulted in a short-lived civil war that brought the Marxist Sandinista guerrillas to power in 1979. Nicaraguan aid to leftist rebels in El Salvador caused the US to sponsor anti-Sandinista contra guerrillas through much of the 1980s. After losing free and fair elections in 1990, 1996, and 2001, former Sandinista President Daniel ORTEGA Saavedra was elected president in 2006 and reelected in 2011. The 2008 municipal elections, 2010 regional elections, 2011 presidential elections, 2012 municipal elections, and 2013 regional elections were marred by widespread irregularities. Nicaragua's infrastructure and economy - hard hit by the earlier civil war and by Hurricane Mitch in 1998 - are slowly being rebuilt, but democratic institutions have been weakened under the ORTEGA administration. ", 13.00, 85.00, 130370);

INSERT INTO Country VALUES ("Niger", "Niger became independent from France in 1960 and experienced single-party and military rule until 1991, when Gen. Ali SAIBOU was forced by public pressure to allow multiparty elections, which resulted in a democratic government in 1993. Political infighting brought the government to a standstill and in 1996 led to a coup by Col. Ibrahim BARE. In 1999, BARE was killed in a counter coup by military officers who restored democratic rule and held elections that brought Mamadou TANDJA to power in December of that year. TANDJA was reelected in 2004 and in 2009 spearheaded a constitutional amendment that would allow him to extend his term as president. In February 2010, a military coup deposed TANDJA, immediately suspended the constitution, and dissolved the Cabinet. ISSOUFOU Mahamadou emerged victorious from a crowded field in the election following the coup and was inaugurated in April 2011. Niger is one of the poorest countries in the world with minimal government services and insufficient funds to develop its resource base. The largely agrarian and subsistence-based economy is frequently disrupted by extended droughts common to the Sahel region of Africa. The Nigerien Movement for Justice, a predominantly ethnic Tuareg rebel group, emerged in February 2007, and attacked several military targets in Niger's northern region throughout 2007 and 2008. Successful government offensives in 2009 ended the rebellion. Niger is facing increased security concerns on its borders from various external threats including insecurity in Libya, spillover from the conflict in Mali, and violent extremism in northeastern Nigeria. ", 16.00, 8.00, 1267000);

INSERT INTO Country VALUES ("Nigeria", "British influence and control over what would become Nigeria and Africa's most populous country grew through the 19th century. A series of constitutions after World War II granted Nigeria greater autonomy; independence came in 1960. Following nearly 16 years of military rule, a new constitution was adopted in 1999, and a peaceful transition to civilian government was completed. The government continues to face the daunting task of reforming a petroleum-based economy, whose revenues have been squandered through corruption and mismanagement, and institutionalizing democracy. In addition, Nigeria continues to experience longstanding ethnic and religious tensions. Although both the 2003 and 2007 presidential elections were marred by significant irregularities and violence, Nigeria is currently experiencing its longest period of civilian rule since independence. The general elections of April 2007 marked the first civilian-to-civilian transfer of power in the country's history and the elections of 2011 were generally regarded as credible. In January 2014, Nigeria assumed a nonpermanent seat on the UN Security Council for the 2014-15 term. ", 10.00, 8.00, 923768);

INSERT INTO Country VALUES ("Niue", "Niue's remoteness, as well as cultural and linguistic differences between its Polynesian inhabitants and those of the adjacent Cook Islands, has caused it to be separately administered by New Zealand. The population of the island continues to drop (from a peak of 5,200 in 1966 to an estimated 1,229 in 2013) with substantial emigration to New Zealand 2,400 km to the southwest. ", 19.02, 169.52, 260);

INSERT INTO Country VALUES ("Norfolk Island", "Two British attempts at establishing the island as a penal colony (1788-1814 and 1825-55) were ultimately abandoned. In 1856, the island was resettled by Pitcairn Islanders, descendants of the Bounty mutineers and their Tahitian companions. ", 29.02, 167.57, 36);

INSERT INTO Country VALUES ("Northern Mariana Islands", "Under US administration as part of the UN Trust Territory of the Pacific, the people of the Northern Mariana Islands decided in the 1970s not to seek independence but instead to forge closer links with the US. Negotiations for territorial status began in 1972. A covenant to establish a commonwealth in political union with the US was approved in 1975, and came into force on 24 March 1976. A new government and constitution went into effect in 1978. ", 15.12, 145.45, 464);

INSERT INTO Country VALUES ("Norway", "Two centuries of Viking raids into Europe tapered off following the adoption of Christianity by King Olav TRYGGVASON in 994. Conversion of the Norwegian kingdom occurred over the next several decades. In 1397, Norway was absorbed into a union with Denmark that lasted more than four centuries. In 1814, Norwegians resisted the cession of their country to Sweden and adopted a new constitution. Sweden then invaded Norway but agreed to let Norway keep its constitution in return for accepting the union under a Swedish king. Rising nationalism throughout the 19th century led to a 1905 referendum granting Norway independence. Although Norway remained neutral in World War I, it suffered heavy losses to its shipping. Norway proclaimed its neutrality at the outset of World War II, but was nonetheless occupied for five years by Nazi Germany (1940-45). In 1949, neutrality was abandoned and Norway became a member of NATO. Discovery of oil and gas in adjacent waters in the late 1960s boosted Norway's economic fortunes. In referenda held in 1972 and 1994, Norway rejected joining the EU. Key domestic issues include immigration and integration of ethnic minorities, maintaining the country's extensive social safety net with an aging population, and preserving economic competitiveness. ", 62.00, 10.00, 323802);

INSERT INTO Country VALUES ("Oman", "The inhabitants of the area of Oman have long prospered on Indian Ocean trade. In the late 18th century, a newly established sultanate in Muscat signed the first in a series of friendship treaties with Britain. Over time, Oman's dependence on British political and military advisors increased, but it never became a British colony. In 1970, QABOOS bin Said Al-Said overthrew his father, and he has since ruled as sultan. His extensive modernization program has opened the country to the outside world while preserving the longstanding close ties with the UK. Oman's moderate, independent foreign policy has sought to maintain good relations with all Middle Eastern countries. Inspired by the popular uprisings that swept the Middle East and North Africa beginning in January 2011, some Omanis began staging marches, demonstrations, and sit-ins calling mostly for more jobs and economic benefits and an end to corruption. In response to those protester demands, QABOOS in 2011 pledged to implement economic and political reforms, such as granting legislative and regulatory powers to the Majlis al-Shura and introducing unemployment benefits. Additionally, in August 2012, the Sultan announced a royal directive mandating the speedy implementation of a national job creation plan for thousands of public and private sector jobs. As part of the government's efforts to decentralize authority and allow greater citizen participation in local governance, Oman successfully conducted its first municipal council elections in December 2012. Announced by the Sultan in 2011, the municipal councils will have the power to advise the Royal Court on the needs of local districts across Oman's 11 governorates. ", 21.00, 57.00, 309500);

INSERT INTO Country VALUES ("Pakistan", "The Indus Valley civilization, one of the oldest in the world and dating back at least 5,000 years, spread over much of what is presently Pakistan. During the second millennium B.C., remnants of this culture fused with the migrating Indo-Aryan peoples. The area underwent successive invasions in subsequent centuries from the Persians, Greeks, Scythians, Arabs (who brought Islam), Afghans, and Turks. The Mughal Empire flourished in the 16th and 17th centuries; the British came to dominate the region in the 18th century. The separation in 1947 of British India into the Muslim state of Pakistan (with West and East sections) and largely Hindu India was never satisfactorily resolved, and India and Pakistan fought two wars - in 1947-48 and 1965 - over the disputed Kashmir territory. A third war between these countries in 1971 - in which India capitalized on Islamabad's marginalization of Bengalis in Pakistani politics - resulted in East Pakistan becoming the separate nation of Bangladesh. In response to Indian nuclear weapons testing, Pakistan conducted its own tests in 1998. India-Pakistan relations have been rocky since the November 2008 Mumbai attacks, but both countries are taking small steps to put relations back on track. In February 2008, Pakistan held parliamentary elections and in September 2008, after the resignation of former President MUSHARRAF, elected Asif Ali ZARDARI to the presidency. Pakistani government and military leaders are struggling to control domestic insurgents, many of whom are located in the tribal areas adjacent to the border with Afghanistan. ", 30.00, 70.00, 796095);

INSERT INTO Country VALUES ("Palau", "After three decades as part of the UN Trust Territory of the Pacific under US administration, this westernmost cluster of the Caroline Islands opted for independence in 1978 rather than join the Federated States of Micronesia. A Compact of Free Association with the US was approved in 1986 but not ratified until 1993. It entered into force the following year when the islands gained independence. ", 7.30, 134.30, 459);

INSERT INTO Country VALUES ("Palmyra Atoll", "The Kingdom of Hawaii claimed the atoll in 1862, and the US included it among the Hawaiian Islands when it annexed the archipelago in 1898. The Hawaii Statehood Act of 1959 did not include Palmyra Atoll, which is now part privately owned by the Nature Conservancy and part US Government-owned and administered as a nature preserve. The lagoons and surrounding waters within the 12-nautical-mile US territorial seas were transferred to the US Fish and Wildlife Service and were designated a National Wildlife Refuge in January 2001. ", 5.52, 162.04, 11);

INSERT INTO Country VALUES ("Panama", "Explored and settled by the Spanish in the 16th century, Panama broke with Spain in 1821 and joined a union of Colombia, Ecuador, and Venezuela - named the Republic of Gran Colombia. When the latter dissolved in 1830, Panama remained part of Colombia. With US backing, Panama seceded from Colombia in 1903 and promptly signed a treaty with the US allowing for the construction of a canal and US sovereignty over a strip of land on either side of the structure (the Panama Canal Zone). The Panama Canal was built by the US Army Corps of Engineers between 1904 and 1914. In 1977, an agreement was signed for the complete transfer of the Canal from the US to Panama by the end of the century. Certain portions of the Zone and increasing responsibility over the Canal were turned over in the subsequent decades. With US help, dictator Manuel NORIEGA was deposed in 1989. The entire Panama Canal, the area supporting the Canal, and remaining US military bases were transferred to Panama by the end of 1999. In October 2006, Panamanians approved an ambitious plan (estimated to cost $5.3 billion) to expand the Canal. The project, which began in 2007 and could double the Canal's capacity, is expected to be completed in 2015. ", 9.00, 80.00, 75420);

INSERT INTO Country VALUES ("Papua New Guinea", "The eastern half of the island of New Guinea - second largest in the world - was divided between Germany (north) and the UK (south) in 1885. The latter area was transferred to Australia in 1902, which occupied the northern portion during World War I and continued to administer the combined areas until independence in 1975. A nine-year secessionist revolt on the island of Bougainville ended in 1997 after claiming some 20,000 lives. ", 6.00, 147.00, 462840);

INSERT INTO Country VALUES ("Paraguay", "Paraguay achieved its independence from Spain in 1811. In the disastrous War of the Triple Alliance (1865-70) - between Paraguay and Argentina, Brazil, and Uruguay - Paraguay lost two-thirds of its adult males and much of its territory. The country stagnated economically for the next half century. Following the Chaco War of 1932-35 with Bolivia, Paraguay gained a large part of the Chaco lowland region. The 35-year military dictatorship of Alfredo STROESSNER ended in 1989, and, despite a marked increase in political infighting in recent years, Paraguay has held relatively free and regular presidential elections since the country's return to democracy. ", 23.00, 58.00, 406752);

INSERT INTO Country VALUES ("Peru", "Ancient Peru was the seat of several prominent Andean civilizations, most notably that of the Incas whose empire was captured by Spanish conquistadors in 1533. Peruvian independence was declared in 1821, and remaining Spanish forces were defeated in 1824. After a dozen years of military rule, Peru returned to democratic leadership in 1980, but experienced economic problems and the growth of a violent insurgency. President Alberto FUJIMORI's election in 1990 ushered in a decade that saw a dramatic turnaround in the economy and significant progress in curtailing guerrilla activity. Nevertheless, the president's increasing reliance on authoritarian measures and an economic slump in the late 1990s generated mounting dissatisfaction with his regime, which led to his resignation in 2000. A caretaker government oversaw new elections in the spring of 2001, which installed Alejandro TOLEDO Manrique as the new head of government - Peru's first democratically elected president of indigenous ethnicity. The presidential election of 2006 saw the return of Alan GARCIA Perez who, after a disappointing presidential term from 1985 to 1990, oversaw a robust economic rebound. In June 2011, former army officer Ollanta HUMALA Tasso was elected president, defeating Keiko FUJIMORI Higuchi, the daughter of Alberto FUJIMORI. Since his election, HUMALA has carried on the sound, market-oriented economic policies of the three preceding administrations. ", 10.00, 76.00, 1285216);

INSERT INTO Country VALUES ("Philippines", "The Philippine Islands became a Spanish colony during the 16th century; they were ceded to the US in 1898 following the Spanish-American War. In 1935 the Philippines became a self-governing commonwealth. Manuel QUEZON was elected president and was tasked with preparing the country for independence after a 10-year transition. In 1942 the islands fell under Japanese occupation during World War II, and US forces and Filipinos fought together during 1944-45 to regain control. On 4 July 1946 the Republic of the Philippines attained its independence. A 20-year rule by Ferdinand MARCOS ended in 1986, when a ''people power'' movement in Manila (''EDSA 1'') forced him into exile and installed Corazon AQUINO as president. Her presidency was hampered by several coup attempts that prevented a return to full political stability and economic development. Fidel RAMOS was elected president in 1992. His administration was marked by increased stability and by progress on economic reforms. In 1992, the US closed its last military bases on the islands. Joseph ESTRADA was elected president in 1998. He was succeeded by his vice-president, Gloria MACAPAGAL-ARROYO, in January 2001 after ESTRADA's stormy impeachment trial on corruption charges broke down and another ''people power'' movement (''EDSA 2'') demanded his resignation. MACAPAGAL-ARROYO was elected to a six-year term as president in May 2004. Her presidency was marred by several corruption allegations but the Philippine economy was one of the few to avoid contraction following the 2008 global financial crisis, expanding each year of her administration. Benigno AQUINO III was elected to a six-year term as president in May 2010. The Philippine Government faces threats from several groups, some of which are on the US Government's Foreign Terrorist Organization list. Manila has waged a decades-long struggle against ethnic Moro insurgencies in the southern Philippines, which has led to a peace accord with the Moro National Liberation Front and ongoing peace talks with the Moro Islamic Liberation Front. The decades-long Maoist-inspired New People's Army insurgency also operates through much of the country. The Philippines faces increased tension with China over disputed territorial and maritime claims in the South China Sea. ", 13.00, 122.00, 300000);

INSERT INTO Country VALUES ("Pitcairn Islands", "Pitcairn Island was discovered in 1767 by the British and settled in 1790 by the Bounty mutineers and their Tahitian companions. Pitcairn was the first Pacific island to become a British colony (in 1838) and today remains the last vestige of that empire in the South Pacific. Outmigration, primarily to New Zealand, has thinned the population from a peak of 233 in 1937 to less than 50 today. ", 25.04, 130.06, 47);

INSERT INTO Country VALUES ("Poland", "Poland's history as a state begins near the middle of the 10th century. By the mid-16th century, the Polish-Lithuanian Commonwealth ruled a vast tract of land in central and eastern Europe. During the 18th century, internal disorders weakened the nation, and in a series of agreements between 1772 and 1795, Russia, Prussia, and Austria partitioned Poland among themselves. Poland regained its independence in 1918 only to be overrun by Germany and the Soviet Union in World War II. It became a Soviet satellite state following the war, but its government was comparatively tolerant and progressive. Labor turmoil in 1980 led to the formation of the independent trade union ''Solidarity'' that over time became a political force with over ten million members. Free elections in 1989 and 1990 won Solidarity control of the parliament and the presidency, bringing the communist era to a close. A ''shock therapy'' program during the early 1990s enabled the country to transform its economy into one of the most robust in Central Europe. Poland joined NATO in 1999 and the European Union in 2004. With its transformation to a democratic, market-oriented country largely completed and with large investments in defense, energy, and other infrastructure, Poland is an increasingly active member of Euro-Atlantic organizations. ", 52.00, 20.00, 312685);

INSERT INTO Country VALUES ("Portugal", "Following its heyday as a global maritime power during the 15th and 16th centuries, Portugal lost much of its wealth and status with the destruction of Lisbon in a 1755 earthquake, occupation during the Napoleonic Wars, and the independence of Brazil, its wealthiest colony, in 1822. A 1910 revolution deposed the monarchy; for most of the next six decades, repressive governments ran the country. In 1974, a left-wing military coup installed broad democratic reforms. The following year, Portugal granted independence to all of its African colonies. Portugal is a founding member of NATO and entered the EC (now the EU) in 1986. ", 39.30, 8.00, 92090);

INSERT INTO Country VALUES ("Puerto Rico", "Populated for centuries by aboriginal peoples, the island was claimed by the Spanish Crown in 1493 following Christopher COLUMBUS' second voyage to the Americas. In 1898, after 400 years of colonial rule that saw the indigenous population nearly exterminated and African slave labor introduced, Puerto Rico was ceded to the US as a result of the Spanish-American War. Puerto Ricans were granted US citizenship in 1917. Popularly-elected governors have served since 1948. In 1952, a constitution was enacted providing for internal self government. In plebiscites held in 1967, 1993, and 1998, voters chose not to alter the existing political status with the US, but the results of a 2012 vote left open the possibility of American statehood. ", 18.15, 66.30, 13790);

INSERT INTO Country VALUES ("Qatar", "Ruled by the Al Thani family since the mid-1800s, Qatar transformed itself from a poor British protectorate noted mainly for pearling into an independent state with significant oil and natural gas revenues. During the late 1980s and early 1990s, the Qatari economy was crippled by a continuous siphoning off of petroleum revenues by the Amir, who had ruled the country since 1972. His son, the current Amir HAMAD bin Khalifa Al Thani, overthrew the father in a bloodless coup in 1995. In short order, HAMAD oversaw the creation of the pan-Arab satellite news network Al-Jazeera and Qatar's pursuit of a leadership role in mediating regional conflicts. In the 2000s, Qatar resolved its longstanding border disputes with both Bahrain and Saudi Arabia. As of 2007, oil and natural gas revenues had enabled Qatar to attain the highest per capita income in the world. Qatar has not experienced domestic unrest or violence like that seen in other Near Eastern and North African countries in 2010-11, due in part to its immense wealth. Since the outbreak of regional unrest, however, Doha has prided itself on its support for many of these popular revolutions, particularly in Libya and Syria. In mid-2013, HAMAD transferred power to his 33 year-old son, TAMIM bin Hamad - a peaceful abdication rare in the history of Arab Gulf states. TAMIM has prioritized improving the domestic welfare of Qataris, including establishing advanced healthcare and education systems and expanding the country's infrastructure in anticipation of Doha's hosting of the 2022 World Cup. ", 25.30, 51.15, 11586);

INSERT INTO Country VALUES ("Romania", "The principalities of Wallachia and Moldavia - for centuries under the suzerainty of the Turkish Ottoman Empire - secured their autonomy in 1856; they were de facto linked in 1859 and formally united in 1862 under the new name of Romania. The country gained recognition of its independence in 1878. It joined the Allied Powers in World War I and acquired new territories - most notably Transylvania - following the conflict. In 1940, Romania allied with the Axis powers and participated in the 1941 German invasion of the USSR. Three years later, overrun by the Soviets, Romania signed an armistice. The post-war Soviet occupation led to the formation of a communist ''people's republic'' in 1947 and the abdication of the king. The decades-long rule of dictator Nicolae CEAUSESCU, who took power in 1965, and his Securitate police state became increasingly oppressive and draconian through the 1980s. CEAUSESCU was overthrown and executed in late 1989. Former communists dominated the government until 1996 when they were swept from power. Romania joined NATO in 2004 and the EU in 2007. ", 46.00, 25.00, 238391);

INSERT INTO Country VALUES ("Russia", "Founded in the 12th century, the Principality of Muscovy, was able to emerge from over 200 years of Mongol domination (13th-15th centuries) and to gradually conquer and absorb surrounding principalities. In the early 17th century, a new ROMANOV Dynasty continued this policy of expansion across Siberia to the Pacific. Under PETER I (ruled 1682-1725), hegemony was extended to the Baltic Sea and the country was renamed the Russian Empire. During the 19th century, more territorial acquisitions were made in Europe and Asia. Defeat in the Russo-Japanese War of 1904-05 contributed to the Revolution of 1905, which resulted in the formation of a parliament and other reforms. Repeated devastating defeats of the Russian army in World War I led to widespread rioting in the major cities of the Russian Empire and to the overthrow in 1917 of the imperial household. The communists under Vladimir LENIN seized power soon after and formed the USSR. The brutal rule of Iosif STALIN (1928-53) strengthened communist rule and Russian dominance of the Soviet Union at a cost of tens of millions of lives. The Soviet economy and society stagnated in the following decades until General Secretary Mikhail GORBACHEV (1985-91) introduced glasnost (openness) and perestroika (restructuring) in an attempt to modernize communism, but his initiatives inadvertently released forces that by December 1991 splintered the USSR into Russia and 14 other independent republics. Since then, Russia has shifted its post-Soviet democratic ambitions in favor of a centralized semi-authoritarian state in which the leadership seeks to legitimize its rule through managed national elections, populist appeals by President PUTIN, and continued economic growth. Russia has severely disabled a Chechen rebel movement, although violence still occurs throughout the North Caucasus. ", 60.00, 100.00, 17098242);

INSERT INTO Country VALUES ("Rwanda", "In 1959, three years before independence from Belgium, the majority ethnic group, the Hutus, overthrew the ruling Tutsi king. Over the next several years, thousands of Tutsis were killed, and some 150,000 driven into exile in neighboring countries. The children of these exiles later formed a rebel group, the Rwandan Patriotic Front (RPF), and began a civil war in 1990. The war, along with several political and economic upheavals, exacerbated ethnic tensions, culminating in April 1994 in a state-orchestrated genocide, in which Rwandans killed up to a million of their fellow citizens, including approximately three-quarters of the Tutsi population. The genocide ended later that same year when the predominantly Tutsi RPF, operating out of Uganda and northern Rwanda, defeated the national army and Hutu militias, and established an RPF-led government of national unity. Approximately 2 million Hutu refugees - many fearing Tutsi retribution - fled to neighboring Burundi, Tanzania, Uganda, and former Zaire. Since then, most of the refugees have returned to Rwanda, but several thousand remained in the neighboring Democratic Republic of the Congo (DRC, the former Zaire) and formed an extremist insurgency bent on retaking Rwanda, much as the RPF did in 1990. Rwanda held its first local elections in 1999 and its first post-genocide presidential and legislative elections in 2003. Rwanda in 2009 staged a joint military operation with the Congolese Army in DRC to rout out the Hutu extremist insurgency there, and Kigali and Kinshasa restored diplomatic relations. Rwanda also joined the Commonwealth in late 2009. In January 2013, Rwanda assumed a nonpermanent seat on the UN Security Council for the 2013-14 term. ", 2.00, 30.00, 26338);

INSERT INTO Country VALUES ("Saint Barthelemy", "Discovered in 1493 by Christopher COLUMBUS who named it for his brother Bartolomeo, Saint Barthelemy was first settled by the French in 1648. In 1784, the French sold the island to Sweden, who renamed the largest town Gustavia, after the Swedish King GUSTAV III, and made it a free port; the island prospered as a trade and supply center during the colonial wars of the 18th century. France repurchased the island in 1877 and took control the following year. It was placed under the administration of Guadeloupe. Saint Barthelemy retained its free port status along with various Swedish appellations such as Swedish street and town names, and the three-crown symbol on the coat of arms. In 2003 the populace of the island voted to secede from Guadeloupe, and in 2007 the island became a French overseas collectivity. ", 17.90, 62.85, 21);

INSERT INTO Country VALUES ("Saint Kitts and Nevis", "Carib Indians occupied the islands of the West Indies for hundreds of years before the British began settlement in 1623. In 1967, the island territory of Saint Christopher-Nevis-Anguilla became an associated state of the UK with full internal autonomy. The island of Anguilla rebelled and was allowed to secede in 1971. The remaining islands achieved independence in 1983 as Saint Kitts and Nevis. In 1998, a vote in Nevis on a referendum to separate from Saint Kitts fell short of the two-thirds majority needed. Nevis continues in its efforts to separate from Saint Kitts. ", 17.20, 62.45, 261);

INSERT INTO Country VALUES ("Saint Lucia", "The island, with its fine natural harbor at Castries, was contested between England and France throughout the 17th and early 18th centuries (changing possession 14 times); it was finally ceded to the UK in 1814. Even after the abolition of slavery on its plantations in 1834, Saint Lucia remained an agricultural island, dedicated to producing tropical commodity crops. Self-government was granted in 1967 and independence in 1979. ", 13.53, 60.58, 616);

INSERT INTO Country VALUES ("Saint Martin", "Although sighted by Christopher COLUMBUS in 1493 and claimed for Spain, it was the Dutch who occupied the island in 1631 and set about exploiting its salt deposits. The Spanish retook the island in 1633, but continued to be harassed by the Dutch. The Spanish finally relinquished Saint Martin to the French and Dutch, who divided it between themselves in 1648. Friction between the two sides caused the border to frequently fluctuate over the next two centuries, with the French eventually holding the greater portion of the island (about 57%). The cultivation of sugar cane introduced African slavery to the island in the late 18th century; the practice was not abolished until 1848. The island became a free port in 1939; the tourism industry was dramatically expanded during the 1970s and 1980s. In 2003, the populace of Saint Martin voted to secede from Guadeloupe and in 2007, the northern portion of the island became a French overseas collectivity. In 2010, the southern Dutch portion of the island became the independent nation of Sint Maarten within the Kingdom of the Netherlands. ", 18.05, 63.57, 54);

INSERT INTO Country VALUES ("Saint Pierre and Miquelon", "First settled by the French in the early 17th century, the islands represent the sole remaining vestige of France's once vast North American possessions. ", 46.50, 56.20, 242);

INSERT INTO Country VALUES ("Saint Vincent and the Grenadines", "Resistance by native Caribs prevented colonization on Saint Vincent until 1719. Disputed between France and the United Kingdom for most of the 18th century, the island was ceded to the latter in 1783. Between 1960 and 1962, Saint Vincent and the Grenadines was a separate administrative unit of the Federation of the West Indies. Autonomy was granted in 1969 and independence in 1979. ", 13.15, 61.12, 389);

INSERT INTO Country VALUES ("Samoa", "New Zealand occupied the German protectorate of Western Samoa at the outbreak of World War I in 1914. It continued to administer the islands as a mandate and then as a trust territory until 1962, when the islands became the first Polynesian nation to reestablish independence in the 20th century. The country dropped the ''Western'' from its name in 1997. ", 13.35, 172.20, 2831);

INSERT INTO Country VALUES ("San Marino", "Geographically the third smallest state in Europe (after the Holy See and Monaco), San Marino also claims to be the world's oldest republic. According to tradition, it was founded by a Christian stonemason named MARINUS in A.D. 301. San Marino's foreign policy is aligned with that of the European Union, although it is not a member; social and political trends in the republic track closely with those of its larger neighbor, Italy. ", 43.46, 12.25, 61);

INSERT INTO Country VALUES ("Sao Tome and Principe", "Discovered and claimed by Portugal in the late 15th century, the islands' sugar-based economy gave way to coffee and cocoa in the 19th century - all grown with African plantation slave labor, a form of which lingered into the 20th century. While independence was achieved in 1975, democratic reforms were not instituted until the late 1980s. The country held its first free elections in 1991, but frequent internal wrangling between the various political parties precipitated repeated changes in leadership and two failed coup attempts in 1995 and 2003. In 2012, three opposition parties combined in a no confidence vote to bring down the majority government of former Prime Minister Patrice TROVOADA. The new government of Prime Minister Gabriel Arcanjo Ferreira DA COSTA is entirely composed of opposition party members with limited experience in governance. New oil discoveries in the Gulf of Guinea may attract increased attention to the small island nation. ", 1.00, 7.00, 964);

INSERT INTO Country VALUES ("Saudi Arabia", "Saudi Arabia is the birthplace of Islam and home to Islam's two holiest shrines in Mecca and Medina. The king's official title is the Custodian of the Two Holy Mosques. The modern Saudi state was founded in 1932 by ABD AL-AZIZ bin Abd al-Rahman Al SAUD (Ibn Saud) after a 30-year campaign to unify most of the Arabian Peninsula. One of his male descendants rules the country today, as required by the country's 1992 Basic Law. King ABDALLAH bin Abd al-Aziz ascended to the throne in 2005. Following Iraq's invasion of Kuwait in 1990, Saudi Arabia accepted the Kuwaiti royal family and 400,000 refugees while allowing Western and Arab troops to deploy on its soil for the liberation of Kuwait the following year. The continuing presence of foreign troops on Saudi soil after the liberation of Kuwait became a source of tension between the royal family and the public until all operational US troops left the country in 2003. Major terrorist attacks in May and November 2003 spurred a strong on-going campaign against domestic terrorism and extremism. King ABDALLAH since 2005 has worked to incrementally modernize the Kingdom - driven by personal ideology and political pragmatism - through a series of social and economic initiatives, including expanding employment and social opportunities for women, attracting foreign investment, increasing the role of the private sector in the economy, and discouraging businesses from hiring foreign workers. The Arab Spring inspired protests - increasing in number since 2011 but usually small in size - over primarily domestic issues among Saudi Arabia's majority Sunni population. Riyadh has taken a cautious but firm approach by arresting some protesters but releasing most of them quickly, and by using its state-sponsored clerics to counter political and Islamist activism. In addition, Saudi Arabia has seen protests among the Shia populace in the Eastern Province, who have protested primarily against the detention of political prisoners, endemic discrimination, and Bahraini and Saudi Government actions in Bahrain. Protests are met by a strong police presence, with some arrests, but not the level of bloodshed seen in protests elsewhere in the region. In response to the unrest, King ABDALLAH in February and March 2011 announced a series of benefits to Saudi citizens including funds to build affordable housing, salary increases for government workers, and unemployment entitlements. To promote increased political participation, the government held elections nationwide in September 2011 for half the members of 285 municipal councils - a body that holds little influence in the Saudi Government. Also in September, the king announced that women will be allowed to run for and vote in future municipal elections - first held in 2005 - and serve as full members of the advisory Consultative Council. The country remains a leading producer of oil and natural gas and holds about 17% of the world's proven oil reserves. The government continues to pursue economic reform and diversification, particularly since Saudi Arabia's accession to the WTO in 2005, and promotes foreign investment in the kingdom. A burgeoning population, aquifer depletion, and an economy largely dependent on petroleum output and prices are ongoing governmental concerns. ", 25.00, 45.00, 2149690);

INSERT INTO Country VALUES ("Senegal", "The French colonies of Senegal and the French Sudan were merged in 1959 and granted their independence as the Mali Federation in 1960. The union broke up after only a few months. Senegal joined with The Gambia to form the nominal confederation of Senegambia in 1982. The envisaged integration of the two countries was never carried out, and the union was dissolved in 1989. The Movement of Democratic Forces in the Casamance (MFDC) has led a low-level separatist insurgency in southern Senegal since the 1980s, and several peace deals have failed to resolve the conflict. Nevertheless, Senegal remains one of the most stable democracies in Africa and has a long history of participating in international peacekeeping and regional mediation. Senegal was ruled by a Socialist Party for 40 years until Abdoulaye WADE was elected president in 2000. He was reelected in 2007 and during his two terms amended Senegal's constitution over a dozen times to increase executive power and to weaken the opposition. His decision to run for a third presidential term sparked a large public backlash that led to his defeat in a March 2012 runoff election with Macky SALL. ", 14.00, 14.00, 196722);

INSERT INTO Country VALUES ("Serbia", "The Kingdom of Serbs, Croats, and Slovenes was formed in 1918; its name was changed to Yugoslavia in 1929. Communist Partisans resisted the Axis occupation and division of Yugoslavia from 1941 to 1945 and fought nationalist opponents and collaborators as well. The military and political movement headed by Josip Broz ''TITO'' (Partisans) took full control of Yugoslavia when their domestic rivals and the occupiers were defeated in 1945. Although communists, TITO and his successors (Tito died in 1980) managed to steer their own path between the Warsaw Pact nations and the West for the next four and a half decades. In 1989, Slobodan MILOSEVIC became president of the Republic of Serbia and his ultranationalist calls for Serbian domination led to the violent breakup of Yugoslavia along ethnic lines. In 1991, Croatia, Slovenia, and Macedonia declared independence, followed by Bosnia in 1992. The remaining republics of Serbia and Montenegro declared a new Federal Republic of Yugoslavia (FRY) in April 1992 and under MILOSEVIC's leadership, Serbia led various military campaigns to unite ethnic Serbs in neighboring republics into a ''Greater Serbia.'' These actions were ultimately unsuccessful and, after international intervention, led to the signing of the Dayton Peace Accords in 1995. MILOSEVIC retained control over Serbia and eventually became president of the FRY in 1997. In 1998, an ethnic Albanian insurgency in the formerly autonomous Serbian province of Kosovo provoked a Serbian counterinsurgency campaign that resulted in massacres and massive expulsions of ethnic Albanians living in Kosovo. The MILOSEVIC government's rejection of a proposed international settlement led to NATO's bombing of Serbia in the spring of 1999. Serbian military and police forces withdrew from Kosovo in June 1999, and the UN Security Council authorized an interim UN administration and a NATO-led security force in Kosovo. FRY elections in late 2000 led to the ouster of MILOSEVIC and the installation of democratic government. In 2003, the FRY became the State Union of Serbia and Montenegro, a loose federation of the two republics. Widespread violence predominantly targeting ethnic Serbs in Kosovo in March 2004 let to more intense calls to address Kosovo's status, and the UN began facilitating status talks in 2006. In June 2006, Montenegro seceded from the federation and declared itself an independent nation. Serbia subsequently gave notice that it was the successor state to the union of Serbia and Montenegro. In February 2008, after nearly two years of inconclusive negotiations, Kosovo declared itself independent of Serbia - an action Serbia refuses to recognize. At Serbia's request, the UN General Assembly (UNGA) in October 2008 sought an advisory opinion from the International Court of Justice (ICJ) on whether Kosovo's unilateral declaration of independence was in accordance with international law. In a ruling considered unfavorable to Serbia, the ICJ issued an advisory opinion in July 2010 stating that international law did not prohibit declarations of independence. In late 2010, Serbia agreed to an EU-drafted UNGA Resolution acknowledging the ICJ's decision and calling for a new round of talks between Serbia and Kosovo, this time on practical issues rather than Kosovo's status. The EU-moderated Belgrade-Pristina dialogue began in March 2011 and was raised to the level of prime ministers in October 2012. Serbia and Kosovo signed the first agreement of principles governing the normalization of relations between the two countries in April 2013 and are in the process of implementing its provisions. ", 44.00, 21.00, 77474);

INSERT INTO Country VALUES ("Seychelles", "A lengthy struggle between France and Great Britain for the islands ended in 1814, when they were ceded to the latter. Independence came in 1976. Socialist rule was brought to a close with a new constitution and free elections in 1993. President France-Albert RENE, who had served since 1977, was re-elected in 2001, but stepped down in 2004. Vice President James Alix MICHEL took over the presidency and in July 2006 was elected to a new five-year term; he was reelected in May 2011. ", 4.35, 55.40, 455);

INSERT INTO Country VALUES ("Sierra Leone", "Democracy is slowly being reestablished after the civil war from 1991 to 2002 that resulted in tens of thousands of deaths and the displacement of more than 2 million people (about a third of the population). The military, which took over full responsibility for security following the departure of UN peacekeepers at the end of 2005, is increasingly developing as a guarantor of the country's stability. The armed forces remained on the sideline during the 2007 and 2012 national elections, and over the past year have deployed over 850 peacekeepers in the African Union Mission in Somalia (AMISOM). As of January 2014, Sierra Leone also fielded 122 staff for five UN peacekeeping missions. In March 2014, the closure of the UN Integrated Peacebuilding Office in Sierra Leone (UNIPSIL) marked the end of more than 15 years of peacekeeping and political operations in Sierra Leone. The government's priorities include furthering development, creating jobs, and stamping out endemic corruption. ", 8.30, 11.30, 71740);

INSERT INTO Country VALUES ("Singapore", "Singapore was founded as a British trading colony in 1819. It joined the Malaysian Federation in 1963 but separated two years later and became independent. Singapore subsequently became one of the world's most prosperous countries with strong international trading links (its port is one of the world's busiest in terms of tonnage handled) and with per capita GDP equal to that of the leading nations of Western Europe. ", 1.22, 103.48, 697);

INSERT INTO Country VALUES ("Sint Maarten", "Although sighted by Christopher COLUMBUS in 1493 and claimed for Spain, it was the Dutch who occupied the island in 1631 and set about exploiting its salt deposits. The Spanish retook the island in 1633, but continued to be harassed by the Dutch. The Spanish finally relinquished the island of Saint Martin to the French and Dutch, who divided it amongst themselves in 1648. The establishment of cotton, tobacco, and sugar plantations dramatically expanded African slavery on the island in the 18th and 19th centuries; the practice was not abolished in the Dutch half until 1863. The island's economy declined until 1939 when it became a free port; the tourism industry was dramatically expanded beginning in the 1950s. In 1954, Sint Maarten and several other Dutch Caribbean possessions became part of the Kingdom of the Netherlands as the Netherlands Antilles. In a 2000 referendum, the citizens of Sint Maarten voted to become a self-governing country within the Kingdom of the Netherlands. The change in status became effective in October of 2010 with the dissolution of the Netherlands Antilles. ", 18.4, 63.4, 34);

INSERT INTO Country VALUES ("Slovakia", "Slovakia's roots can be traced to the 9th century state of Great Moravia. Subsequently, the Slovaks became part of the Hungarian Kingdom, where they remained for the next 1,000 years. Following the formation of the dual Austro-Hungarian monarchy in 1867, language and education policies favoring the use of Hungarian (Magyarization) resulted in a strengthening of Slovak nationalism and a cultivation of cultural ties with the closely related Czechs, who were under Austrian rule. After the dissolution of the Austro-Hungarian Empire at the close of World War I, the Slovaks joined the Czechs to form Czechoslovakia. During the interwar period, Slovak nationalist leaders pushed for autonomy within Czechoslovakia, and in 1939 Slovakia became an independent state allied with Nazi Germany. Following World War II, Czechoslovakia was reconstituted and came under communist rule within Soviet-dominated Eastern Europe. In 1968, an invasion by Warsaw Pact troops ended the efforts of the country's leaders to liberalize communist rule and create ''socialism with a human face,'' ushering in a period of repression known as ''normalization.'' The peaceful ''Velvet Revolution'' swept the Communist Party from power at the end of 1989 and inaugurated a return to democratic rule and a market economy. On 1 January 1993, the country underwent a nonviolent ''velvet divorce'' into its two national components, Slovakia and the Czech Republic. Slovakia joined both NATO and the EU in the spring of 2004 and the euro zone on 1 January 2009. ", 48.40, 19.30, 49035);

INSERT INTO Country VALUES ("Slovenia", "The Slovene lands were part of the Austro-Hungarian Empire until the latter's dissolution at the end of World War I. In 1918, the Slovenes joined the Serbs and Croats in forming a new multinational state, which was named Yugoslavia in 1929. After World War II, Slovenia became a republic of the renewed Yugoslavia, which though communist, distanced itself from Moscow's rule. Dissatisfied with the exercise of power by the majority Serbs, the Slovenes succeeded in establishing their independence in 1991 after a short 10-day war. Historical ties to Western Europe, a strong economy, and a stable democracy have assisted in Slovenia's transformation to a modern state. Slovenia acceded to both NATO and the EU in the spring of 2004; it joined the eurozone in 2007. ", 46.07, 14.49, 20273);

INSERT INTO Country VALUES ("Solomon Islands", "The UK established a protectorate over the Solomon Islands in the 1890s. Some of the most bitter fighting of World War II occurred on this archipelago. Self-government was achieved in 1976 and independence two years later. Ethnic violence, government malfeasance, and endemic crime have undermined stability and civil society. In June 2003, then Prime Minister Sir Allan KEMAKEZA sought the assistance of Australia in reestablishing law and order; the following month, an Australian-led multinational force arrived to restore peace and disarm ethnic militias. The Regional Assistance Mission to the Solomon Islands (RAMSI) has generally been effective in restoring law and order and rebuilding government institutions. ", 8.00, 159.00, 28896);

INSERT INTO Country VALUES ("Somalia", "Britain withdrew from British Somaliland in 1960 to allow its protectorate to join with Italian Somaliland and form the new nation of Somalia. In 1969, a coup headed by Mohamed SIAD Barre ushered in an authoritarian socialist rule characterized by the persecution, jailing, and torture of political opponents and dissidents. After the regime's collapse early in 1991, Somalia descended into turmoil, factional fighting, and anarchy. In May 1991, northern clans declared an independent Republic of Somaliland that now includes the administrative regions of Awdal, Woqooyi Galbeed, Togdheer, Sanaag, and Sool. Although not recognized by any government, this entity has maintained a stable existence and continues efforts to establish a constitutional democracy, including holding municipal, parliamentary, and presidential elections. The regions of Bari, Nugaal, and northern Mudug comprise a neighboring semi-autonomous state of Puntland, which has been self-governing since 1998 but does not aim at independence; it has also made strides toward reconstructing a legitimate, representative government but has suffered some civil strife. Puntland disputes its border with Somaliland as it also claims portions of eastern Sool and Sanaag. Beginning in 1993, a two-year UN humanitarian effort (primarily in the south) was able to alleviate famine conditions, but when the UN withdrew in 1995, having suffered significant casualties, order still had not been restored. In 2000, the Somalia National Peace Conference (SNPC) held in Djibouti resulted in the formation of an interim government, known as the Transitional National Government (TNG). When the TNG failed to establish adequate security or governing institutions, the Government of Kenya, under the auspices of the Intergovernmental Authority on Development (IGAD), led a subsequent peace process that concluded in October 2004 with the election of Abdullahi YUSUF Ahmed as President of a second interim government, known as the Transitional Federal Government (TFG) of the Somali Republic. The TFG included a 275-member parliamentary body, known as the Transitional Federal Parliament (TFP). President YUSUF resigned late in 2008 while United Nations-sponsored talks between the TFG and the opposition Alliance for the Re-Liberation of Somalia (ARS) were underway in Djibouti. In January 2009, following the creation of a TFG-ARS unity government, Ethiopian military forces, which had entered Somalia in December 2006 to support the TFG in the face of advances by the opposition Islamic Courts Union (ICU), withdrew from the country. The TFP was doubled in size to 550 seats with the addition of 200 ARS and 75 civil society members of parliament. The expanded parliament elected Sheikh SHARIF Sheikh Ahmed, the former ICU and ARS chairman as president in January 2009. The creation of the TFG was based on the Transitional Federal Charter (TFC), which outlined a five-year mandate leading to the establishment of a new Somali constitution and a transition to a representative government following national elections. In 2009, the TFP amended the TFC to extend TFG's mandate until 2011 and in 2011 Somali principals agreed to institute political transition by August 2012. The transition process ended in September 2012 when clan elders replaced the TFP by appointing 275 members to a new parliament who subsequently elected a new president. ", 10.00, 49.00, 637657);

INSERT INTO Country VALUES ("South Africa", "Dutch traders landed at the southern tip of modern day South Africa in 1652 and established a stopover point on the spice route between the Netherlands and the Far East, founding the city of Cape Town. After the British seized the Cape of Good Hope area in 1806, many of the Dutch settlers (the Boers) trekked north to found their own republics. The discovery of diamonds (1867) and gold (1886) spurred wealth and immigration and intensified the subjugation of the native inhabitants. The Boers resisted British encroachments but were defeated in the Second Anglo Boer War (1899-1902); however, the British and the Afrikaners, as the Boers became known, ruled together beginning in 1910 under the Union of South Africa, which became a republic in 1961 after a whites-only referendum. In 1948, the National Party was voted into power and instituted a policy of apartheid - the separate development of the races - which favored the white minority at the expense of the black majority. The African National Congress (ANC) led the opposition to apartheid and many top ANC leaders, such as Nelson MANDELA, spent decades in South Africa's prisons. Internal protests and insurgency, as well as boycotts by some Western nations and institutions, led to the regime's eventual willingness to negotiate a peaceful transition to majority rule. The first multi-racial elections in 1994 brought an end to apartheid and ushered in majority rule under an ANC-led government. South Africa since then has struggled to address apartheid-era imbalances in decent housing, education, and health care. ANC infighting, which has grown in recent years, came to a head in September 2008 when President Thabo MBEKI resigned, and Kgalema MOTLANTHE, the party's General-Secretary, succeeded him as interim president. Jacob ZUMA became president after the ANC won general elections in April 2009. National presidential and parliamentary elections are scheduled for May 2014. ", 29.00, 24.00, 1219090);

INSERT INTO Country VALUES ("South Georgia and South Sandwich Islands", "The islands, with large bird and seal populations, lie approximately 1,000 km east of the Falkland Islands and have been under British administration since 1908 - except for a brief period in 1982 when Argentina occupied them. Grytviken, on South Georgia, was a 19th and early 20th century whaling station. Famed explorer Ernest SHACKLETON stopped there in 1914 en route to his ill-fated attempt to cross Antarctica on foot. He returned some 20 months later with a few companions in a small boat and arranged a successful rescue for the rest of his crew, stranded off the Antarctic Peninsula. He died in 1922 on a subsequent expedition and is buried in Grytviken. Today, the station houses scientists from the British Antarctic Survey. Recognizing the importance of preserving the marine stocks in adjacent waters, the UK, in 1993, extended the exclusive fishing zone from 12 nm to 200 nm around each island. ", 54.30, 37.00, 3903);

INSERT INTO Country VALUES ("South Sudan", "Egypt attempted to colonize the region of southern Sudan by establishing the province of Equatoria in the 1870s. Islamic Mahdist revolutionaries overran the region in 1885, but in 1898 a British force was able to overthrow the Mahdist regime. An Anglo-Egyptian Sudan was established the following year with Equatoria being the southernmost of its eight provinces. The isolated region was largely left to itself over the following decades, but Christian missionaries converted much of the population and facilitated the spread of English. When Sudan gained its independence in 1956, it was with the understanding that the southerners would be able to participate fully in the political system. When the Arab Khartoum government reneged on its promises, a mutiny began that led to two prolonged periods of conflict (1955-1972 and 1983-2005) in which perhaps 2.5 million people died - mostly civilians - due to starvation and drought. Ongoing peace talks finally resulted in a Comprehensive Peace Agreement, signed in January 2005. As part of this agreement the south was granted a six-year period of autonomy to be followed by a referendum on final status. The result of this referendum, held in January 2011, was a vote of 98% in favor of secession. Independence was attained on 9 July 2011. Since independence South Sudan has struggled with good governance and nation building and has attempted to control rebel militia groups operating in its territory. Economic conditions have deteriorated since January 2012 when the government decided to shut down oil production following bilateral disagreements with Sudan. ", 8.00, 30.00, 644329);

INSERT INTO Country VALUES ("Spain", "Spain's powerful world empire of the 16th and 17th centuries ultimately yielded command of the seas to England. Subsequent failure to embrace the mercantile and industrial revolutions caused the country to fall behind Britain, France, and Germany in economic and political power. Spain remained neutral in World War I and II but suffered through a devastating civil war (1936-39). A peaceful transition to democracy following the death of dictator Francisco FRANCO in 1975, and rapid economic modernization (Spain joined the EU in 1986) gave Spain a dynamic and rapidly growing economy and made it a global champion of freedom and human rights. More recently the government has had to focus on measures to reverse a severe economic recession that began in mid-2008. Austerity measures implemented to reduce a large budget deficit and reassure foreign investors have led to one of the highest unemployment rates in Europe. ", 40.00, 4.00, 505370);

INSERT INTO Country VALUES ("Sri Lanka", "The first Sinhalese arrived in Sri Lanka late in the 6th century B.C., probably from northern India. Buddhism was introduced in about the mid-third century B.C., and a great civilization developed at the cities of Anuradhapura (kingdom from circa 200 B.C. to circa A.D. 1000) and Polonnaruwa (from about 1070 to 1200). In the 14th century, a south Indian dynasty established a Tamil kingdom in northern Sri Lanka. The coastal areas of the island were controlled by the Portuguese in the 16th century and by the Dutch in the 17th century. The island was ceded to the British in 1796, became a crown colony in 1802, and was formally united under British rule by 1815. As Ceylon, it became independent in 1948; its name was changed to Sri Lanka in 1972. Tensions between the Sinhalese majority and Tamil separatists erupted into war in 1983. After two decades of fighting, the government and Liberation Tigers of Tamil Eelam (LTTE) formalized a cease-fire in February 2002 with Norway brokering peace negotiations. Violence between the LTTE and government forces intensified in 2006, but the government regained control of the Eastern Province in 2007. By May 2009, the government announced that its military had defeated the remnants of the LTTE. Since the end of the conflict, the government has enacted an ambitious program of economic development projects, many of which are financed by loans from the Government of China. In addition to efforts to reconstruct its economy, the government has resettled more than 95% of those civilians who were displaced during the final phase of the conflict and released the vast majority of former LTTE combatants captured by Government Security Forces. At the same time, there has been little progress on more contentious and politically difficult issues such as reaching a political settlement with Tamil elected representatives and holding accountable those alleged to have been involved in human rights violations and other abuses during the conflict. ", 7.00, 81.00, 65610);

INSERT INTO Country VALUES ("Sudan", "Military regimes favoring Islamic-oriented governments have dominated national politics since independence from Anglo-Egyptian co rule in 1956. Sudan was embroiled in two prolonged civil wars during most of the remainder of the 20th century. These conflicts were rooted in northern economic, political, and social domination of largely non-Muslim, non-Arab southern Sudanese. The first civil war ended in 1972 but another broke out in 1983. Peace talks gained momentum in 2002-04 with the signing of several accords. The final North/South Comprehensive Peace Agreement (CPA), signed in January 2005, granted the southern rebels autonomy for six years followed by a referendum on independence for Southern Sudan. The referendum was held in January 2011 and indicated overwhelming support for independence. South Sudan became independent on 9 July 2011. Sudan and South Sudan have yet to fully implement security and economic agreements signed on September 27, 2012 relating to the normalization of relations between the two countries. The final disposition of the contested Abyei region has also to be decided. Since South Sudan's independence, conflict has broken out between the government and the Sudan People's Liberation Movement-North (SPLM-N) in Southern Kordofan and Blue Nile states, which has resulted in 1.2 million internally displaced persons or severely affected persons in need of humanitarian assistance. A separate conflict, which broke out in the western region of Darfur in 2003, has displaced nearly two million people and caused an estimated 200,000 to 400,000 deaths. Violence in Darfur in 2013 resulted in an additional estimated 6,000 civilians killed and 500,000 displaced. The UN and the African Union have jointly commanded a Darfur peacekeeping operation known as the African Union-United Nations Hybrid Mission in Darfur (UNAMID) since 2007. Peacekeeping troops have struggled to stabilize the situation and have increasingly become targets for attacks by armed groups. In 2013, 16 peacekeepers were killed, UNAMID's deadliest year so far. Sudan also has faced refugee influxes from neighboring countries, primarily Ethiopia, Eritrea, Chad, Central African Republic, and South Sudan. Armed conflict, poor transport infrastructure, and government denial of access have impeded the provision of humanitarian assistance to affected populations. ", 15.00, 30.00, 1861484);

INSERT INTO Country VALUES ("Suriname", "First explored by the Spaniards in the 16th century and then settled by the English in the mid-17th century, Suriname became a Dutch colony in 1667. With the abolition of African slavery in 1863, workers were brought in from India and Java. Independence from the Netherlands was granted in 1975. Five years later the civilian government was replaced by a military regime that soon declared a socialist republic. It continued to exert control through a succession of nominally civilian administrations until 1987, when international pressure finally forced a democratic election. In 1990, the military overthrew the civilian leadership, but a democratically elected government - a four-party coalition - returned to power in 1991. The coalition expanded to eight parties in 2005 and ruled until August 2010, when voters returned former military leader Desire BOUTERSE and his opposition coalition to power. ", 4.00, 56.00, 163820);

INSERT INTO Country VALUES ("Svalbard", "First discovered by the Norwegians in the 12th century, the islands served as an international whaling base during the 17th and 18th centuries. Norway's sovereignty was recognized in 1920; five years later it officially took over the territory. ", 78.00, 20.00, 62045);

INSERT INTO Country VALUES ("Swaziland", "Autonomy for the Swazis of southern Africa was guaranteed by the British in the late 19th century; independence was granted in 1968. Student and labor unrest during the 1990s pressured King MSWATI III, Africa's last absolute monarch, to grudgingly allow political reform and greater democracy, although he has backslid on these promises in recent years. A constitution came into effect in 2006, but the legal status of political parties remains unclear. The African United Democratic Party tried unsuccessfully to register as an official political party in mid 2006. Talks over the constitution broke down between the government and progressive groups in 2007. Swaziland recently surpassed Botswana as the country with the world's highest known HIV/AIDS prevalence rate. ", 26.30, 31.30, 17364);

INSERT INTO Country VALUES ("Sweden", "A military power during the 17th century, Sweden has not participated in any war for almost two centuries. An armed neutrality was preserved in both world wars. Sweden's long-successful economic formula of a capitalist system intermixed with substantial welfare elements was challenged in the 1990s by high unemployment and in 2000-02 and 2009 by the global economic downturns, but fiscal discipline over the past several years has allowed the country to weather economic vagaries. Sweden joined the EU in 1995, but the public rejected the introduction of the euro in a 2003 referendum. ", 62.00, 15.00, 450295);

INSERT INTO Country VALUES ("Switzerland", "The Swiss Confederation was founded in 1291 as a defensive alliance among three cantons. In succeeding years, other localities joined the original three. The Swiss Confederation secured its independence from the Holy Roman Empire in 1499. A constitution of 1848, subsequently modified in 1874, replaced the confederation with a centralized federal government. Switzerland's sovereignty and neutrality have long been honored by the major European powers, and the country was not involved in either of the two world wars. The political and economic integration of Europe over the past half century, as well as Switzerland's role in many UN and international organizations, has strengthened Switzerland's ties with its neighbors. However, the country did not officially become a UN member until 2002. Switzerland remains active in many UN and international organizations but retains a strong commitment to neutrality. ", 47.00, 8.00, 41277);

INSERT INTO Country VALUES ("Syria", "Following World War I, France acquired a mandate over the northern portion of the former Ottoman Empire province of Syria. The French administered the area as Syria until granting it independence in 1946. The new country lacked political stability, however, and experienced a series of military coups during its first decades. Syria united with Egypt in February 1958 to form the United Arab Republic. In September 1961, the two entities separated, and the Syrian Arab Republic was reestablished. In November 1970, Hafiz al-ASAD, a member of the socialist Ba'th Party and the minority Alawi sect, seized power in a bloodless coup and brought political stability to the country. In the 1967 Arab-Israeli War, Syria lost the Golan Heights to Israel. During the 1990s, Syria and Israel held occasional peace talks over its return. Following the death of President al-ASAD, his son, Bashar al-ASAD, was approved as president by popular referendum in July 2000. Syrian troops - stationed in Lebanon since 1976 in an ostensible peacekeeping role - were withdrawn in April 2005. During the July-August 2006 conflict between Israel and Hizballah, Syria placed its military forces on alert but did not intervene directly on behalf of its ally Hizballah. In May 2007 Bashar al-ASAD's second term as president was approved by popular referendum. Influenced by major uprisings that began elsewhere in the region, antigovernment protests broke out in the southern province of Dar'a in March 2011 with protesters calling for the repeal of the restrictive Emergency Law allowing arrests without charge, the legalization of political parties, and the removal of corrupt local officials. Since then demonstrations and unrest have spread to nearly every city in Syria, but the size and intensity of protests have fluctuated over time. The government responded to unrest with a mix of concessions - including the repeal of the Emergency Law and approving new laws permitting new political parties and liberalizing local and national elections - and force. However, the government's response has failed to meet opposition demands for ASAD to step down, and the government's ongoing security operations to quell unrest and widespread armed opposition activity have led to extended violent clashes between government forces and oppositionists. International pressure on the ASAD regime has intensified since late 2011, as the Arab League, EU, Turkey, and the United States have expanded economic sanctions against the regime. Lakhdar BRAHIMI, current Joint Special Representative of the United Nations and the League of Arab States on the Syrian crisis, in October 2012 began meeting with regional heads of state to assist in brokering a cease-fire. In December 2012, the National Coalition of Syrian Revolution and Opposition Forces was recognized by more than 130 countries as the sole legitimate representative of the Syrian people. Unrest persisted in 2013, and the death toll among Syrian Government forces, opposition forces, and civilians has topped 100,000. In January 2014, the Syrian Opposition Coalition and Syrian regime began peace talks at the UN sponsored Geneva II conference. ", 35.00, 38.00, 185180);

INSERT INTO Country VALUES ("Taiwan", "In 1895, military defeat forced China's Qing Dynasty to cede Taiwan to Japan. Taiwan came under Chinese Nationalist control after World War II. Following the communist victory on the mainland in 1949, 2 million Nationalists fled to Taiwan and established a government using the 1947 constitution drawn up for all of China. Beginning in the 1950s, the ruling authorities gradually democratized and incorporated the local population within the governing structure. This process expanded rapidly in the 1980s. In 2000, Taiwan underwent its first peaceful transfer of power from the Nationalist (Kuomintang or KMT) to the Democratic Progressive Party. Throughout this period, the island prospered and became one of East Asia's economic ''Tigers.'' The dominant political issues continue to be management of sensitive relations between Taiwan and China - specifically the question of Taiwan's eventual status - as well as domestic priorities for economic reform and growth. ", 23.30, 121.00, 35980);

INSERT INTO Country VALUES ("Tajikistan", "The Tajik people came under Russian rule in the 1860s and 1870s, but Russia's hold on Central Asia weakened following the Revolution of 1917. Bands of indigenous guerrillas (called ''basmachi'') fiercely contested Bolshevik control of the area, which was not fully reestablished until 1925. Tajikistan was first created as an autonomous republic within Uzbekistan in 1924, but the USSR designated Tajikistan a separate republic in 1929 and transferred to it much of present-day Sughd province. Ethnic Uzbeks form a substantial minority in Tajikistan. Tajikistan became independent in 1991 following the breakup of the Soviet Union, and experienced a civil war between regional factions from 1992 to 1997. Tajikistan endured several domestic security incidents during 2010-12, including armed conflict between government forces and local strongmen in the Rasht Valley and between government forces and criminal groups in Gorno-Badakhshan Autonomous Oblast. The country remains the poorest in the former Soviet sphere. Tajikistan became a member of the World Trade Organization in March 2013. However, its economy continues to face major challenges, including dependence on remittances from Tajikistanis working in Russia, pervasive corruption, and the major role narcotrafficking plays in the country's informal economy. ", 39.00, 71.00, 143100);

INSERT INTO Country VALUES ("Tanzania", "Shortly after achieving independence from Britain in the early 1960s, Tanganyika and Zanzibar merged to form the nation of Tanzania in 1964. One-party rule ended in 1995 with the first democratic elections held in the country since the 1970s. Zanzibar's semi-autonomous status and popular opposition led to two contentious elections since 1995, which the ruling party won despite international observers' claims of voting irregularities. The formation of a government of national unity between Zanzibar's two leading parties succeeded in minimizing electoral tension in 2010. ", 6.00, 35.00, 947300);

INSERT INTO Country VALUES ("Thailand", "A unified Thai kingdom was established in the mid-14th century. Known as Siam until 1939, Thailand is the only Southeast Asian country never to have been taken over by a European power. A bloodless revolution in 1932 led to a constitutional monarchy. In alliance with Japan during World War II, Thailand became a US treaty ally in 1954 after sending troops to Korea and later fighting alongside the United States in Vietnam. Thailand since 2005 has experienced several rounds of political turmoil including a military coup in 2006 that ousted then Prime Minister THAKSIN Chinnawat, followed by large-scale street protests by competing political factions in 2008, 2009, and 2010. THAKSIN's youngest sister, YINGLAK Chinnawat, in 2011 led the Puea Thai Party to an electoral win and assumed control of the government. A blanket amnesty bill for individuals involved in street protests, altered at the last minute to include all political crimes - including all convictions against THAKSIN - triggered months of large-scale anti-government protests in Bangkok beginning in November 2013. In early May 2014 YINGLAK was removed from office and in late May 2014 the Royal Thai Army staged a coup against the caretaker government. Thailand has also experienced violence associated with the ethno-nationalist insurgency in Thailand's southern Malay-Muslim majority provinces. Since January 2004, thousands have been killed and wounded in the insurgency. ", 15.00, 100.00, 513120);

INSERT INTO Country VALUES ("Timor-Leste", "The Portuguese began to trade with the island of Timor in the early 16th century and colonized it in mid-century. Skirmishing with the Dutch in the region eventually resulted in an 1859 treaty in which Portugal ceded the western portion of the island. Imperial Japan occupied Portuguese Timor from 1942 to 1945, but Portugal resumed colonial authority after the Japanese defeat in World War II. East Timor declared itself independent from Portugal on 28 November 1975 and was invaded and occupied by Indonesian forces nine days later. It was incorporated into Indonesia in July 1976 as the province of Timor Timur (East Timor). An unsuccessful campaign of pacification followed over the next two decades, during which an estimated 100,000 to 250,000 individuals lost their lives. On 30 August 1999, in a UN-supervised popular referendum, an overwhelming majority of the people of Timor-Leste voted for independence from Indonesia. However, in the next three weeks, anti-independence Timorese militias - organized and supported by the Indonesian military - commenced a large-scale, scorched-earth campaign of retribution. The militias killed approximately 1,400 Timorese and forcibly pushed 300,000 people into western Timor as refugees. Most of the country's infrastructure, including homes, irrigation systems, water supply systems, and schools, and nearly 100% of the country's electrical grid were destroyed. On 20 September 1999, Australian-led peacekeeping troops deployed to the country and brought the violence to an end. On 20 May 2002, Timor-Leste was internationally recognized as an independent state. In 2006, internal tensions threatened the new nation's security when a military strike led to violence and a breakdown of law and order. At Dili's request, an Australian-led International Stabilization Force (ISF) deployed to Timor-Leste, and the UN Security Council established the UN Integrated Mission in Timor-Leste (UNMIT), which included an authorized police presence of over 1,600 personnel. The ISF and UNMIT restored stability, allowing for presidential and parliamentary elections in 2007 in a largely peaceful atmosphere. In February 2008, a rebel group staged an unsuccessful attack against the president and prime minister. The ringleader was killed in the attack, and most of the rebels surrendered in April 2008. Since the attack, the government has enjoyed one of its longest periods of post-independence stability, including successful 2012 elections for both the parliament and president. In late 2012, the UN Security Council voted to end its peacekeeping mission in Timor-Leste and both the ISF and UNMIT departed the country by the end of the year. ", 8.50, 125.55, 14874);

INSERT INTO Country VALUES ("Togo", "French Togoland became Togo in 1960. Gen. Gnassingbe EYADEMA, installed as military ruler in 1967, ruled Togo with a heavy hand for almost four decades. Despite the facade of multi-party elections instituted in the early 1990s, the government was largely dominated by President EYADEMA, whose Rally of the Togolese People (RPT) party has maintained power almost continually since 1967 and maintains a majority of seats in today's legislature. Upon EYADEMA's death in February 2005, the military installed the president's son, Faure GNASSINGBE, and then engineered his formal election two months later. Democratic gains since then allowed Togo to hold its first relatively free and fair legislative elections in October 2007. After years of political unrest and condemnation from international organizations for human rights abuses, Togo is finally being re-welcomed into the international community. ", 8.00, 1.10, 56785);

INSERT INTO Country VALUES ("Tokelau", "Originally settled by Polynesian emigrants from surrounding island groups, the Tokelau Islands were made a British protectorate in 1889. They were transferred to New Zealand administration in 1925. Referenda held in 2006 and 2007 to change the status of the islands from that of a New Zealand territory to one of free association with New Zealand did not meet the needed threshold for approval. ", 9.00, 172.00, 12);

INSERT INTO Country VALUES ("Tonga", "Tonga - unique among Pacific nations - never completely lost its indigenous governance. The archipelagos of ''The Friendly Islands'' were united into a Polynesian kingdom in 1845. Tonga became a constitutional monarchy in 1875 and a British protectorate in 1900; it withdrew from the protectorate and joined the Commonwealth of Nations in 1970. Tonga remains the only monarchy in the Pacific. ", 20.00, 175.00, 747);

INSERT INTO Country VALUES ("Trinidad and Tobago", "First colonized by the Spanish, the islands came under British control in the early 19th century. The islands' sugar industry was hurt by the emancipation of the slaves in 1834. Manpower was replaced with the importation of contract laborers from India between 1845 and 1917, which boosted sugar production as well as the cocoa industry. The discovery of oil on Trinidad in 1910 added another important export. Independence was attained in 1962. The country is one of the most prosperous in the Caribbean thanks largely to petroleum and natural gas production and processing. Tourism, mostly in Tobago, is targeted for expansion and is growing. The government is coping with a rise in violent crime. ", 11.00, 61.00, 5128);

INSERT INTO Country VALUES ("Tunisia", "Rivalry between French and Italian interests in Tunisia culminated in a French invasion in 1881 and the creation of a protectorate. Agitation for independence in the decades following World War I was finally successful in getting the French to recognize Tunisia as an independent state in 1956. The country's first president, Habib BOURGUIBA, established a strict one-party state. He dominated the country for 31 years, repressing Islamic fundamentalism and establishing rights for women unmatched by any other Arab nation. In November 1987, BOURGUIBA was removed from office and replaced by Zine el Abidine BEN ALI in a bloodless coup. Street protests that began in Tunis in December 2010 over high unemployment, corruption, widespread poverty, and high food prices escalated in January 2011, culminating in rioting that led to hundreds of deaths. On 14 January 2011, the same day BEN ALI dismissed the government, he fled the country, and by late January 2011, a ''national unity government'' was formed. Elections for the new Constituent Assembly were held in late October 2011, and in December, it elected human rights activist Moncef MARZOUKI as interim president. The Assembly began drafting a new constitution in February 2012 and, after several iterations and a months-long political crisis that stalled the transition, ratified the document in January 2014. Presidential and parliamentary elections for a permanent government could be held by the end of 2014. ", 34.00, 9.00, 163610);

INSERT INTO Country VALUES ("Turkey", "Modern Turkey was founded in 1923 from the Anatolian remnants of the defeated Ottoman Empire by national hero Mustafa KEMAL, who was later honored with the title Ataturk or ''Father of the Turks.'' Under his leadership, the country adopted wide-ranging social, legal, and political reforms. After a period of one-party rule, an experiment with multi-party politics led to the 1950 election victory of the opposition Democratic Party and the peaceful transfer of power. Since then, Turkish political parties have multiplied, but democracy has been fractured by periods of instability and intermittent military coups (1960, 1971, 1980), which in each case eventually resulted in a return of political power to civilians. In 1997, the military again helped engineer the ouster - popularly dubbed a ''post-modern coup'' - of the then Islamic-oriented government. Turkey intervened militarily on Cyprus in 1974 to prevent a Greek takeover of the island and has since acted as patron state to the ''Turkish Republic of Northern Cyprus,'' which only Turkey recognizes. A separatist insurgency begun in 1984 by the Kurdistan Workers' Party (PKK) - now known as the Kurdistan People's Congress or Kongra-Gel (KGK) - has dominated the Turkish military's attention and claimed more than 30,000 lives. After the capture of the group's leader in 1999, the insurgents largely withdrew from Turkey mainly to northern Iraq. In 2013, KGK and the Turkish Government agreed to a ceasefire that continues despite slow progress in ongoing peace talks. Turkey joined the UN in 1945 and in 1952 it became a member of NATO. In 1964, Turkey became an associate member of the European Community. Over the past decade, it has undertaken many reforms to strengthen its democracy and economy; it began accession membership talks with the European Union in 2005. ", 39.00, 35.00, 783562);

INSERT INTO Country VALUES ("Turkmenistan", "Present-day Turkmenistan covers territory that has been at the crossroads of civilizations for centuries. The area was ruled in antiquity by various Persian empires, and was conquered by Alexander the Great, Muslim crusaders, the Mongols, Turkic warriors, and eventually the Russians. In medieval times Merv (today known as Mary) was one of the great cities of the Islamic world and an important stop on the Silk Road. Annexed by Russia in the late 1800s, Turkmenistan later figured prominently in the anti-Bolshevik movement in Central Asia. In 1924, Turkmenistan became a Soviet republic; it achieved independence upon the dissolution of the USSR in 1991. Extensive hydrocarbon/natural gas reserves, which have yet to be fully exploited, have begun to transform the country. Turkmenistan is moving to expand its extraction and delivery projects. The Government of Turkmenistan is actively working to diversify its gas export routes beyond the still important Russian pipeline network. In 2010, new gas export pipelines that carry Turkmen gas to China and to northern Iran began operating, effectively ending the Russian monopoly on Turkmen gas exports. President for Life Saparmurat NYYAZOW died in December 2006, and Turkmenistan held its first multi-candidate presidential election in February 2007. Gurbanguly BERDIMUHAMEDOW, a deputy cabinet chairman under NYYAZOW, emerged as the country's new president; he was chosen as president again in February 2012, in an election that the OSCE said lacked the freedoms necessary to create a competitive environment. ", 40.00, 60.00, 488100);

INSERT INTO Country VALUES ("Turks and Caicos Islands", "The islands were part of the UK's Jamaican colony until 1962, when they assumed the status of a separate crown colony upon Jamaica's independence. The governor of The Bahamas oversaw affairs from 1965 to 1973. With Bahamian independence, the islands received a separate governor in 1973. Although independence was agreed upon for 1982, the policy was reversed and the islands remain a British overseas territory. ", 21.45, 71.35, 948);

INSERT INTO Country VALUES ("Tuvalu", "In 1974, ethnic differences within the British colony of the Gilbert and Ellice Islands caused the Polynesians of the Ellice Islands to vote for separation from the Micronesians of the Gilbert Islands. The following year, the Ellice Islands became the separate British colony of Tuvalu. Independence was granted in 1978. In 2000, Tuvalu negotiated a contract leasing its Internet domain name ''.tv'' for $50 million in royalties over a 12-year period. ", 8.00, 178.00, 26);

INSERT INTO Country VALUES ("Uganda", "The colonial boundaries created by Britain to delimit Uganda grouped together a wide range of ethnic groups with different political systems and cultures. These differences prevented the establishment of a working political community after independence was achieved in 1962. The dictatorial regime of Idi AMIN (1971-79) was responsible for the deaths of some 300,000 opponents; guerrilla war and human rights abuses under Milton OBOTE (1980-85) claimed at least another 100,000 lives. The rule of Yoweri MUSEVENI since 1986 has brought relative stability and economic growth to Uganda. A constitutional referendum in 2005 cancelled a 19-year ban on multi-party politics. ", 1.00, 32.00, 241038);

INSERT INTO Country VALUES ("Ukraine", "Ukraine was the center of the first eastern Slavic state, Kyivan Rus, which during the 10th and 11th centuries was the largest and most powerful state in Europe. Weakened by internecine quarrels and Mongol invasions, Kyivan Rus was incorporated into the Grand Duchy of Lithuania and eventually into the Polish-Lithuanian Commonwealth. The cultural and religious legacy of Kyivan Rus laid the foundation for Ukrainian nationalism through subsequent centuries. A new Ukrainian state, the Cossack Hetmanate, was established during the mid-17th century after an uprising against the Poles. Despite continuous Muscovite pressure, the Hetmanate managed to remain autonomous for well over 100 years. During the latter part of the 18th century, most Ukrainian ethnographic territory was absorbed by the Russian Empire. Following the collapse of czarist Russia in 1917, Ukraine was able to achieve a short-lived period of independence (1917-20), but was reconquered and forced to endure a brutal Soviet rule that engineered two forced famines (1921-22 and 1932-33) in which over 8 million died. In World War II, German and Soviet armies were responsible for some 7 to 8 million more deaths. Although final independence for Ukraine was achieved in 1991 with the dissolution of the USSR, democracy and prosperity remained elusive as the legacy of state control and endemic corruption stalled efforts at economic reform, privatization, and civil liberties. A peaceful mass protest ''Orange Revolution'' in the closing months of 2004 forced the authorities to overturn a rigged presidential election and to allow a new internationally monitored vote that swept into power a reformist slate under Viktor YUSHCHENKO. Subsequent internal squabbles in the YUSHCHENKO camp allowed his rival Viktor YANUKOVYCH to stage a comeback in parliamentary (Rada) elections and to become prime minister in August of 2006, and to be elected president in February 2010. In October 2012, Ukraine held Rada elections, widely criticized by Western observers as flawed due to use of government resources to favor ruling party candidates, interference with media access, and harassment of opposition candidates. President YANUKOVYCH's backtracking on a trade and cooperation agreement with the EU in November 2013 - in favor of closer economic ties with Russia - led to a three-month protest occupation of Kyiv's central square. The government's eventual use of force to break up the protest camp in February 2014 led to all out pitched battles, scores of deaths, international condemnation, and the president's abrupt departure to Russia. An interim government scheduled new presidential elections for 25 May 2014. On 1 March 2014, one week after the overthrow in Kyiv, Russian President PUTIN ordered the invasion of Ukraine's Crimean Peninsula claiming the action was to protect ethnic Russians living there. On 16 March 2014, a ''referendum'' was held regarding the integration of Crimea into the Russian Federation. The ''referendum'' was condemned as illegitimate by the Ukrainian Government, the EU, the US, and the UN General Assembly. Russian forces now occupy Crimea and Russian authorities claim it as Russian territory. The Ukrainian Government asserts that Crimea remains part of Ukraine. ", 49.00, 32.00, 603550);

INSERT INTO Country VALUES ("United Arab Emirates", "The Trucial States of the Persian Gulf coast granted the UK control of their defense and foreign affairs in 19th century treaties. In 1971, six of these states - Abu Dhabi, 'Ajman, Al Fujayrah, Ash Shariqah, Dubayy, and Umm al Qaywayn - merged to form the United Arab Emirates (UAE). They were joined in 1972 by Ra's al Khaymah. The UAE's per capita GDP is on par with those of leading West European nations. Its high oil revenues and its moderate foreign policy stance have allowed the UAE to play a vital role in the affairs of the region. For more than three decades, oil and global finance drove the UAE's economy. However, in 2008-09, the confluence of falling oil prices, collapsing real estate prices, and the international banking crisis hit the UAE especially hard. The UAE has essentially avoided the ''Arab Spring'' unrest seen elsewhere in the Middle East, though in March 2011, political activists and intellectuals signed a petition calling for greater public participation in governance that was widely circulated on the Internet. In an effort to stem potential further unrest, the government announced a multi-year, $1.6-billion infrastructure investment plan for the poorer northern emirates and aggressively pursued advocates of political reform. ", 24.00, 54.00, 83600);

INSERT INTO Country VALUES ("United Kingdom", "The United Kingdom has historically played a leading role in developing parliamentary democracy and in advancing literature and science. At its zenith in the 19th century, the British Empire stretched over one-fourth of the earth's surface. The first half of the 20th century saw the UK's strength seriously depleted in two world wars and the Irish Republic's withdrawal from the union. The second half witnessed the dismantling of the Empire and the UK rebuilding itself into a modern and prosperous European nation. As one of five permanent members of the UN Security Council and a founding member of NATO and the Commonwealth, the UK pursues a global approach to foreign policy. The UK is also an active member of the EU, although it chose to remain outside the Economic and Monetary Union. The Scottish Parliament, the National Assembly for Wales, and the Northern Ireland Assembly were established in 1999. The latter was suspended until May 2007 due to wrangling over the peace process, but devolution was fully completed in March 2010. ", 54.00, 2.00, 243610);

INSERT INTO Country VALUES ("United States", "Britain's American colonies broke with the mother country in 1776 and were recognized as the new nation of the United States of America following the Treaty of Paris in 1783. During the 19th and 20th centuries, 37 new states were added to the original 13 as the nation expanded across the North American continent and acquired a number of overseas possessions. The two most traumatic experiences in the nation's history were the Civil War (1861-65), in which a northern Union of states defeated a secessionist Confederacy of 11 southern slave states, and the Great Depression of the 1930s, an economic downturn during which about a quarter of the labor force lost its jobs. Buoyed by victories in World Wars I and II and the end of the Cold War in 1991, the US remains the world's most powerful nation state. Since the end of World War II, the economy has achieved relatively steady growth, low unemployment and inflation, and rapid advances in technology. ", 38.00, 97.00, 9826675);

INSERT INTO Country VALUES ("Uruguay", "Montevideo, founded by the Spanish in 1726 as a military stronghold, soon took advantage of its natural harbor to become an important commercial center. Claimed by Argentina but annexed by Brazil in 1821, Uruguay declared its independence four years later and secured its freedom in 1828 after a three-year struggle. The administrations of President Jose BATLLE in the early 20th century launched widespread political, social, and economic reforms that established a statist tradition. A violent Marxist urban guerrilla movement named the Tupamaros, launched in the late 1960s, led Uruguay's president to cede control of the government to the military in 1973. By yearend, the rebels had been crushed, but the military continued to expand its hold over the government. Civilian rule was not restored until 1985. In 2004, the left-of-center Frente Amplio Coalition won national elections that effectively ended 170 years of political control previously held by the Colorado and Blanco parties. Uruguay's political and labor conditions are among the freest on the continent. ", 33.00, 56.00, 176215);

INSERT INTO Country VALUES ("Uzbekistan", "Russia conquered the territory of present-day Uzbekistan in the late 19th century. Stiff resistance to the Red Army after the Bolshevik Revolution was eventually suppressed and a socialist republic established in 1924. During the Soviet era, intensive production of ''white gold'' (cotton) and grain led to overuse of agrochemicals and the depletion of water supplies, which have left the land degraded and the Aral Sea and certain rivers half dry. Independent since 1991, the country has lessened its dependence on the cotton monoculture by diversifying agricultural production while developing its mineral and petroleum export capacity and increasing its manufacturing base. However, longserving septuagenarian President Islom KARIMOV, who rose through the ranks of the Soviet-era State Planning Committee (Gosplan), remains wedded to the concepts of a command economy, creating a challenging environment for foreign investment. Current concerns include post-KARIMOV succession, terrorism by Islamic militants, economic stagnation, and the curtailment of human rights and democratization. ", 41.00, 64.00, 447400);

INSERT INTO Country VALUES ("Vanuatu", "Multiple waves of colonizers, each speaking a distinct language, migrated to the New Hebrides in the millennia preceding European exploration in the 18th century. This settlement pattern accounts for the complex linguistic diversity found on the archipelago to this day. The British and French, who settled the New Hebrides in the 19th century, agreed in 1906 to an Anglo-French Condominium, which administered the islands until independence in 1980, when the new name of Vanuatu was adopted. ", 16.00, 167.00, 12189);

INSERT INTO Country VALUES ("Venezuela", "Venezuela was one of three countries that emerged from the collapse of Gran Colombia in 1830 (the others being Ecuador and New Granada, which became Colombia). For most of the first half of the 20th century, Venezuela was ruled by generally benevolent military strongmen, who promoted the oil industry and allowed for some social reforms. Democratically elected governments have held sway since 1959. Hugo CHAVEZ, president from 1999 to 2013, sought to implement his ''21st Century Socialism,'' which purported to alleviate social ills while at the same time attacking capitalist globalization and existing democratic institutions. His hand-picked successor, President Nicolas MADURO, continues CHAVEZ's socialist programs. Current concerns include: a weakening of democratic institutions, political polarization, a politicized military, rampant violent crime, overdependence on the petroleum industry with its price fluctuations, foreign exchange controls that discourage private-sector investment, high inflation, a decline in the quality of fundamental houman rights, and widespread scarcity of consumer goods. ", 8.00, 66.00, 912050);

INSERT INTO Country VALUES ("Vietnam", "The conquest of Vietnam by France began in 1858 and was completed by 1884. It became part of French Indochina in 1887. Vietnam declared independence after World War II, but France continued to rule until its 1954 defeat by communist forces under Ho Chi MINH. Under the Geneva Accords of 1954, Vietnam was divided into the communist North and anti-communist South. US economic and military aid to South Vietnam grew through the 1960s in an attempt to bolster the government, but US armed forces were withdrawn following a cease-fire agreement in 1973. Two years later, North Vietnamese forces overran the South reuniting the country under communist rule. Despite the return of peace, for over a decade the country experienced little economic growth because of conservative leadership policies, the persecution and mass exodus of individuals - many of them successful South Vietnamese merchants - and growing international isolation. However, since the enactment of Vietnam's ''doi moi'' (renovation) policy in 1986, Vietnamese authorities have committed to increased economic liberalization and enacted structural reforms needed to modernize the economy and to produce more competitive, export-driven industries. The communist leaders, however, maintain control on political expression and have resisted outside calls to improve human rights. The country continues to experience small-scale protests from various groups - the vast majority connected to land-use issues, calls for increased political space, and the lack of equitable mechanisms for resolving disputes. Various ethnic minorities, such as the Montagnards of the Central Highlands and the Khmer Krom in the southern delta region, have also held protests. ", 16.10, 107.50, 331210);

INSERT INTO Country VALUES ("Virgin Islands", "The Danes secured control over the southern Virgin Islands of Saint Thomas, Saint John, and Saint Croix during the 17th and early 18th centuries. Sugarcane, produced by African slave labor, drove the islands' economy during the 18th and early 19th centuries. In 1917, the US purchased the Danish holdings, which had been in economic decline since the abolition of slavery in 1848. ", 18.20, 64.50, 1910);

INSERT INTO Country VALUES ("Wake Island", "The US annexed Wake Island in 1899 for a cable station. An important air and naval base was constructed in 1940-41. In December 1941, the island was captured by the Japanese and held until the end of World War II. In subsequent years, Wake became a stopover and refueling site for military and commercial aircraft transiting the Pacific. Since 1974, the island's airstrip has been used by the US military, as well as for emergency landings. Operations on the island were suspended and all personnel evacuated in 2006 with the approach of super typhoon IOKE (category 5), but resultant damage was comparatively minor. A US Air Force repair team restored full capability to the airfield and facilities, and the island remains a vital strategic link in the Pacific region. ", 19.17, 166.39, 6);

INSERT INTO Country VALUES ("Wallis and Futuna", "The Futuna island group was discovered by the Dutch in 1616 and Wallis by the British in 1767, but it was the French who declared a protectorate over the islands in 1842, and took official control of them between 1886 and 1888. Notably, Wallis and Futuna was the only French colony to side with the Vichy regime during World War II, a phase that ended in May of 1942 with the arrival of 2,000 American troops. In 1959, the inhabitants of the islands voted to become a French overseas territory and officially assumed this status in July 1961. ", 13.18, 176.12, 142);

INSERT INTO Country VALUES ("West Bank", "From the early 16th century through 1917, the area now known as the West Bank fell under Ottoman rule. Following World War I, the Allied powers (France, UK, Russia) allocated the area to the British Mandate of Palestine. After World War II, the UN passed a resolution to establish two states within the Mandate, and designated a territory including what is now known as the West Bank as part of the proposed Arab state. Following the 1948 Arab-Israeli War the area was captured by Transjordan (later renamed Jordan). Jordan annexed the West Bank in 1950. In June 1967, Israel captured the West Bank and East Jerusalem during the 1967 Six-Day War. With the exception of East Jerusalem and the former Israeli-Jordanian border zone, the West Bank has remained under Israeli military control. Under a series of agreements signed between 1994 and 1999, Israel transferred to the Palestinian Authority (PA) security and civilian responsibility for many Palestinian-populated areas of the West Bank as well as the Gaza Strip. Negotiations to determine the permanent status of the West Bank and Gaza Strip stalled after the outbreak of an intifada in mid- 2000. In early 2003, the ''Quartet'' of the US, EU, UN, and Russia, presented a roadmap to a final peace settlement by 2005, calling for two states - Israel and a democratic Palestine. Following Palestinian leader Yasir ARAFAT's death in late 2004 and the subsequent election of Mahmud ABBAS (head of the Fatah political party) as the PLO Executive Committee Chairman and PA president, Israel and the PA agreed to move the peace process forward. Israel in late 2005 unilaterally withdrew all of its settlers and soldiers and dismantled its military facilities in the Gaza Strip and redeployed its military from several West Bank settlements but continues to control maritime, airspace, and other access. In early 2006, the Islamic Resistance Movement, HAMAS, won the Palestinian Legislative Council election and took control of the PA government. Attempts to form a unity government failed, and violent clashes between Fatah and HAMAS supporters ensued, culminating in HAMAS's violent seizure of all military and governmental institutions in the Gaza Strip. Fatah and HAMAS in early 2011 agreed to reunify the Gaza Strip and West Bank, but the factions have struggled to implement details on governance and security. The status quo remains with HAMAS in control of the Gaza Strip and the PA governing the West Bank. In late 2010, direct peace talks between the Israelis and Palestinians collapsed. In November 2012, the UN General Assembly upgraded the Palestinian status at the UN to that of an observer ''state.'' The Israeli government and ABBAS returned to formal peace negotiations in July 2013. ", 32.00, 35.15, 5860);

INSERT INTO Country VALUES ("Western Sahara", "Western Sahara is a disputed territory on the northwest coast of Africa bordered by Morocco, Mauritania, and Algeria. After Spain withdrew from its former colony of Spanish Sahara in 1976, Morocco annexed the northern two-thirds of Western Sahara and claimed the rest of the territory in 1979, following Mauritania's withdrawal. A guerrilla war with the Polisario Front contesting Morocco's sovereignty ended in a 1991 cease-fire and the establishment of a UN peacekeeping operation. As part of this effort, the UN sought to offer a choice to the peoples of the Western Sahara between independence (favored by the Polisario Front) or integration into Morocco. A proposed referendum never took place due to lack of agreement on voter eligibility. The 2,700 km- (1,700 mi-) long defensive sand berm, built by the Moroccans from 1980 to 1987 and running the length of the territory, continues to separate the opposing forces with Morocco controlling the roughly 80 percent of the territory west of the berm. Local demonstrations criticizing the Moroccan authorities occur regularly, and there are periodic ethnic tensions between the native Sahrawi population and Moroccan immigrants. Morocco maintains a heavy security presence in the territory. ", 24.30, 13.00, 266000);

INSERT INTO Country VALUES ("Yemen", "North Yemen became independent of the Ottoman Empire in 1918. The British, who had set up a protectorate area around the southern port of Aden in the 19th century, withdrew in 1967 from what became South Yemen. Three years later, the southern government adopted a Marxist orientation. The massive exodus of hundreds of thousands of Yemenis from the south to the north contributed to two decades of hostility between the states. The two countries were formally unified as the Republic of Yemen in 1990. A southern secessionist movement and brief civil war in 1994 was quickly subdued. In 2000, Saudi Arabia and Yemen agreed to a delimitation of their border. Fighting in the northwest between the government and the Huthis, a Zaydi Shia minority, began in 2004 and has since resulted in six rounds of fighting - the last ended in early 2010 with a cease-fire that continues to hold. The southern secessionist movement was revitalized in 2008 when a popular socioeconomic protest movement initiated the prior year took on political goals including secession. Public rallies in Sana'a against then President SALIH - inspired by similar demonstrations in Tunisia and Egypt - slowly built momentum starting in late January 2011 fueled by complaints over high unemployment, poor economic conditions, and corruption. By the following month, some protests had resulted in violence, and the demonstrations had spread to other major cities. By March the opposition had hardened its demands and was unifying behind calls for SALIH's immediate ouster, and prominent military and tribal leaders began defecting from SALIH's camp. The Gulf Cooperation Council (GCC) in late April 2011, in an attempt to mediate the crisis in Yemen, proposed an agreement in which the president would step down in exchange for immunity from prosecution. SALIH's refusal to sign an agreement led to heavy street fighting and his injury in an explosion in June 2011. The UN Security Council passed Resolution 2014 in October 2011 calling on both sides to end the violence and complete a power transfer deal. In late November 2011, SALIH signed the GCC-brokered agreement to step down and to transfer some of his powers to Vice President Abd Rabuh Mansur HADI. Following elections in February 2012, won by HADI, SALIH formally transferred his powers. In accordance with the GCC initiative, Yemen launched a National Dialogue in March 2013 to discuss key constitutional, political, and social issues. HADI concluded the National Dialogue in January 2014. Subsequent steps in the transition process include constitutional drafting, a constitutional referendum, and national elections. ", 15.00, 48.00, 527968);

INSERT INTO Country VALUES ("Zambia", "The territory of Northern Rhodesia was administered by the [British] South Africa Company from 1891 until it was taken over by the UK in 1923. During the 1920s and 1930s, advances in mining spurred development and immigration. The name was changed to Zambia upon independence in 1964. In the 1980s and 1990s, declining copper prices, economic mismanagement and a prolonged drought hurt the economy. Elections in 1991 brought an end to one-party rule, but the subsequent vote in 1996 saw blatant harassment of opposition parties. The election in 2001 was marked by administrative problems with three parties filing a legal petition challenging the election of ruling party candidate Levy MWANAWASA. MWANAWASA was reelected in 2006 in an election that was deemed free and fair. Upon his abrupt death in August 2008, he was succeeded by his vice president, Rupiah BANDA, who subsequently won a special presidential by-election in October 2008. Michael SATA was elected president in September 2011. ", 15.00, 30.00, 752618);

INSERT INTO Country VALUES ("Zimbabwe", "The UK annexed Southern Rhodesia from the [British] South Africa Company in 1923. A 1961 constitution was formulated that favored whites in power. In 1965 the government unilaterally declared its independence, but the UK did not recognize the act and demanded more complete voting rights for the black African majority in the country (then called Rhodesia). UN sanctions and a guerrilla uprising finally led to free elections in 1979 and independence (as Zimbabwe) in 1980. Robert MUGABE, the nation's first prime minister, has been the country's only ruler (as president since 1987) and has dominated the country's political system since independence. His chaotic land redistribution campaign, which began in 1997 and intensified after 2000, caused an exodus of white farmers, crippled the economy, and ushered in widespread shortages of basic commodities. Ignoring international condemnation, MUGABE rigged the 2002 presidential election to ensure his reelection. In April 2005, the capital city of Harare embarked on Operation Restore Order, ostensibly an urban rationalization program, which resulted in the destruction of the homes or businesses of 700,000 mostly poor supporters of the opposition. President MUGABE in June 2007 instituted price controls on all basic commodities causing panic buying and leaving store shelves empty for months; a period of increasing hyperinflation ensued. General elections held in March 2008 contained irregularities but still amounted to a censure of the ZANU-PF-led government with the opposition winning a majority of seats in parliament. MDC-T opposition leader Morgan TSVANGIRAI won the most votes in the presidential polls, but not enough to win outright. In the lead up to a run-off election in late June 2008, considerable violence enacted against opposition party members led to the withdrawal of TSVANGIRAI from the ballot. Extensive evidence of violence and intimidation resulted in international condemnation of the process. Difficult negotiations over a power-sharing ''government of national unity,'' in which MUGABE remained president and TSVANGIRAI became prime minister, were finally settled in February 2009, although the leaders failed to agree upon many key outstanding governmental issues. MUGABE was reelected president in June 2013 in balloting that was severely flawed and internationally condemned. As a prerequisite to holding the elections, Zimbabwe enacted a new constitution by referendum, although many provisions in the new constitution have yet to be codified in law. ", 20.00, 30.00, 390757);


INSERT INTO User VALUES (0, "Sharyl", "Brantley", 27, "shabrantley@hotmail.com", "EN", "", "Mauritius");
INSERT INTO User VALUES (1, "Efren", "Maxwell", 16, "efrmaxwell@hotmail.com", "ES", "", "Madagascar");
INSERT INTO User VALUES (2, "Kaydence", "Brennan", 23, "kaybrennan@sbcglobal.net", "ES", "", "Honduras");
INSERT INTO User VALUES (3, "Moses", "Christensen", 84, "moschristensen@facebook.com", "ES", "", "Germany");
INSERT INTO User VALUES (4, "Alvera", "Holliday", 35, "alvholliday@yahoo.com", "EN", "", "Heard Island and McDonald Islands");
INSERT INTO User VALUES (5, "Moriah", "Sheets", 22, "morsheets@hotmail.com", "ES", "", "Faroe Islands");
INSERT INTO User VALUES (6, "Kamryn", "Craig", 60, "kamcraig@aol.com", "EN", "", "Burundi");
INSERT INTO User VALUES (7, "Baby", "Morris", 15, "babmorris@aol.com", "EN", "", "Bhutan");
INSERT INTO User VALUES (8, "Leann", "Willey", 67, "leawilley@hotmail.com", "EN", "", "Algeria");
INSERT INTO User VALUES (9, "Kimberlie", "Edmonds", 33, "kimedmonds@aol.com", "ES", "", "Canada");
INSERT INTO User VALUES (10, "Crockett", "Sylvester", 55, "crosylvester@yahoo.com", "EN", "", "Bouvet Island");
INSERT INTO User VALUES (11, "Gloria", "Redding", 72, "gloredding@gmail.com", "EN", "", "Ethiopia");
INSERT INTO User VALUES (12, "Willie", "Costello", 62, "wilcostello@yahoo.com", "EN", "", "Comoros");
INSERT INTO User VALUES (13, "Ellie", "Yazzie", 27, "ellyazzie@facebook.com", "ES", "", "Faroe Islands");
INSERT INTO User VALUES (14, "Sherwin", "Chaney", 36, "shechaney@yahoo.com", "ES", "", "Syria");
INSERT INTO User VALUES (15, "Goldie", "Murdock", 79, "golmurdock@yahoo.com", "ES", "", "French Polynesia");
INSERT INTO User VALUES (16, "Albin", "Mansfield", 91, "albmansfield@sbcglobal.net", "ES", "", "Liechtenstein");
INSERT INTO User VALUES (17, "Dina", "Carmona", 73, "dincarmona@mail.ru", "ES", "", "Palmyra Atoll");
INSERT INTO User VALUES (18, "Matthias", "Mercer", 81, "matmercer@mail.ru", "ES", "", "Senegal");
INSERT INTO User VALUES (19, "Alda", "Terrell", 27, "aldterrell@aol.com", "ES", "", "Micronesia, Federated States of");
INSERT INTO User VALUES (20, "Edw", "Huntley", 30, "edwhuntley@sbcglobal.net", "EN", "", "Niue");
INSERT INTO User VALUES (21, "Tucker", "Meade", 25, "tucmeade@hotmail.com", "EN", "", "Andorra");
INSERT INTO User VALUES (22, "Vergie", "Toth", 28, "vertoth@sbcglobal.net", "EN", "", "Estonia");
INSERT INTO User VALUES (23, "Yaritza", "Greer", 43, "yargreer@mail.ru", "ES", "", "Luxembourg");
INSERT INTO User VALUES (24, "Isidro", "Curtis", 73, "isicurtis@aol.com", "ES", "", "Morocco");
INSERT INTO User VALUES (25, "Aditya", "Livingston", 17, "adilivingston@facebook.com", "EN", "", "Brunei");
INSERT INTO User VALUES (26, "Anais", "Felix", 25, "anafelix@facebook.com", "EN", "", "Iceland");
INSERT INTO User VALUES (27, "Reuben", "Lemon", 67, "reulemon@sbcglobal.net", "EN", "", "Luxembourg");
INSERT INTO User VALUES (28, "Johnie", "Schafer", 39, "johschafer@facebook.com", "EN", "", "British Virgin Islands");
INSERT INTO User VALUES (29, "Rutha", "Esposito", 45, "rutesposito@gmail.com", "EN", "", "Benin");
INSERT INTO User VALUES (30, "Webb", "Sample", 24, "websample@mail.ru", "ES", "", "Latvia");
INSERT INTO User VALUES (31, "Rubye", "Craven", 54, "rubcraven@gmail.com", "EN", "", "Gibraltar");
INSERT INTO User VALUES (32, "Merilyn", "Edmondson", 36, "meredmondson@hotmail.com", "ES", "", "Howland Island");
INSERT INTO User VALUES (33, "Nathaly", "Stacy", 52, "natstacy@gmail.com", "EN", "", "Tonga");
INSERT INTO User VALUES (34, "Latifah", "Marshall", 24, "latmarshall@hotmail.com", "ES", "", "West Bank");
INSERT INTO User VALUES (35, "Chalmer", "Finley", 73, "chafinley@sbcglobal.net", "ES", "", "Oman");
INSERT INTO User VALUES (36, "Jaidyn", "Wolfe", 75, "jaiwolfe@aol.com", "ES", "", "Slovenia");
INSERT INTO User VALUES (37, "Kalyn", "Platt", 20, "kalplatt@gmail.com", "ES", "", "Croatia");
INSERT INTO User VALUES (38, "Rillie", "Donovan", 68, "rildonovan@hotmail.com", "ES", "", "Brunei");
INSERT INTO User VALUES (39, "Lakeisha", "Frost", 46, "lakfrost@aol.com", "EN", "", "Austria");
INSERT INTO User VALUES (40, "Jaquez", "Meza", 64, "jaqmeza@sbcglobal.net", "ES", "", "Hungary");
INSERT INTO User VALUES (41, "Carmella", "Hartman", 30, "carhartman@hotmail.com", "ES", "", "Suriname");
INSERT INTO User VALUES (42, "Henderson", "Paris", 32, "henparis@hotmail.com", "ES", "", "Serbia");
INSERT INTO User VALUES (43, "Mozella", "Inman", 71, "mozinman@hotmail.com", "ES", "", "Andorra");
INSERT INTO User VALUES (44, "Alivia", "Grayson", 18, "aligrayson@sbcglobal.net", "EN", "", "Burundi");
INSERT INTO User VALUES (45, "Dossie", "Hodge", 63, "doshodge@sbcglobal.net", "EN", "", "Mauritania");
INSERT INTO User VALUES (46, "Alvina", "Dutton", 57, "alvdutton@mail.ru", "ES", "", "Botswana");
INSERT INTO User VALUES (47, "Jaquan", "Mock", 41, "jaqmock@gmail.com", "EN", "", "Ethiopia");
INSERT INTO User VALUES (48, "Burton", "Gillis", 63, "burgillis@yahoo.com", "ES", "", "Hungary");
INSERT INTO User VALUES (49, "Carleton", "Madrid", 14, "carmadrid@mail.ru", "ES", "", "Syria");
INSERT INTO User VALUES (50, "Millie", "Lara", 43, "millara@aol.com", "EN", "", "Saint Martin");
INSERT INTO User VALUES (51, "Woodroe", "Stafford", 46, "woostafford@mail.ru", "ES", "", "Northern Mariana Islands");
INSERT INTO User VALUES (52, "Vere", "Redmond", 24, "verredmond@sbcglobal.net", "ES", "", "Algeria");
INSERT INTO User VALUES (53, "Denzil", "Dowling", 73, "dendowling@aol.com", "ES", "", "Ireland");
INSERT INTO User VALUES (54, "Addison", "Walden", 55, "addwalden@aol.com", "EN", "", "Iceland");
INSERT INTO User VALUES (55, "Sada", "Nicholson", 82, "sadnicholson@sbcglobal.net", "EN", "", "Marshall Islands");
INSERT INTO User VALUES (56, "Lavar", "Caudill", 35, "lavcaudill@gmail.com", "EN", "", "Turkey");
INSERT INTO User VALUES (57, "Jayvon", "Pugh", 47, "jaypugh@hotmail.com", "ES", "", "Latvia");
INSERT INTO User VALUES (58, "Kourtney", "Denton", 90, "koudenton@mail.ru", "ES", "", "Cote d'Ivoire");
INSERT INTO User VALUES (59, "Janell", "Madrid", 74, "janmadrid@facebook.com", "ES", "", "Jersey");
INSERT INTO User VALUES (60, "Humphrey", "Hoskins", 39, "humhoskins@aol.com", "EN", "", "Gambia, The");
INSERT INTO User VALUES (61, "Nyah", "Hollis", 62, "nyahollis@hotmail.com", "EN", "", "Northern Mariana Islands");
INSERT INTO User VALUES (62, "Kirt", "Crook", 59, "kircrook@aol.com", "EN", "", "Slovenia");
INSERT INTO User VALUES (63, "Laurence", "Rangel", 14, "laurangel@facebook.com", "ES", "", "Saint Kitts and Nevis");
INSERT INTO User VALUES (64, "Ingrid", "Calvert", 18, "ingcalvert@mail.ru", "ES", "", "Saint Martin");
INSERT INTO User VALUES (65, "Jasmin", "Funk", 67, "jasfunk@mail.ru", "ES", "", "Congo, Republic of the");
INSERT INTO User VALUES (66, "Harrold", "Couture", 77, "harcouture@mail.ru", "ES", "", "Portugal");
INSERT INTO User VALUES (67, "Jazmyne", "Krause", 46, "jazkrause@hotmail.com", "ES", "", "Tajikistan");
INSERT INTO User VALUES (68, "Zita", "Harms", 82, "zitharms@facebook.com", "ES", "", "Laos");
INSERT INTO User VALUES (69, "Cherelle", "Magee", 49, "chemagee@facebook.com", "ES", "", "Micronesia, Federated States of");
INSERT INTO User VALUES (70, "Sidney", "Nava", 36, "sidnava@hotmail.com", "ES", "", "Maldives");
INSERT INTO User VALUES (71, "Darold", "Beard", 13, "darbeard@mail.ru", "ES", "", "Kingman Reef");
INSERT INTO User VALUES (72, "Hassan", "Duffy", 61, "hasduffy@hotmail.com", "EN", "", "Falkland Islands (Islas Malvinas)");
INSERT INTO User VALUES (73, "Chynna", "Looney", 18, "chylooney@gmail.com", "ES", "", "Kuwait");
INSERT INTO User VALUES (74, "Charlie", "Hinds", 21, "chahinds@aol.com", "ES", "", "Equatorial Guinea");
INSERT INTO User VALUES (75, "Elia", "Prince", 38, "eliprince@facebook.com", "EN", "", "Aruba");
INSERT INTO User VALUES (76, "Bernardo", "Winkler", 65, "berwinkler@sbcglobal.net", "EN", "", "Faroe Islands");
INSERT INTO User VALUES (77, "Deena", "Billings", 47, "deebillings@yahoo.com", "ES", "", "Iraq");
INSERT INTO User VALUES (78, "Tatyana", "Mccormack", 45, "tatmccormack@gmail.com", "ES", "", "Central African Republic");
INSERT INTO User VALUES (79, "Annetta", "Torrez", 71, "anntorrez@mail.ru", "ES", "", "Italy");
INSERT INTO User VALUES (80, "Allean", "Choi", 38, "allchoi@mail.ru", "ES", "", "Paraguay");
INSERT INTO User VALUES (81, "Hobson", "Hinojosa", 13, "hobhinojosa@sbcglobal.net", "EN", "", "Slovenia");
INSERT INTO User VALUES (82, "Severt", "Crow", 43, "sevcrow@mail.ru", "ES", "", "Norfolk Island");
INSERT INTO User VALUES (83, "Bryana", "Reid", 27, "bryreid@gmail.com", "EN", "", "Bahamas, The");
INSERT INTO User VALUES (84, "Trevon", "Melendez", 54, "tremelendez@gmail.com", "EN", "", "Japan");
INSERT INTO User VALUES (85, "Nevada", "Lorenz", 86, "nevlorenz@sbcglobal.net", "ES", "", "El Salvador");
INSERT INTO User VALUES (86, "Trey", "Bland", 87, "trebland@gmail.com", "ES", "", "Zimbabwe");
INSERT INTO User VALUES (87, "Normand", "Bartholomew", 85, "norbartholomew@aol.com", "EN", "", "Pitcairn Islands");
INSERT INTO User VALUES (88, "Henretta", "Melvin", 38, "henmelvin@facebook.com", "EN", "", "United Arab Emirates");
INSERT INTO User VALUES (89, "Cressie", "Ivy", 55, "creivy@mail.ru", "ES", "", "Greece");
INSERT INTO User VALUES (90, "Triston", "Hewitt", 57, "trihewitt@sbcglobal.net", "EN", "", "Canada");
INSERT INTO User VALUES (91, "Emmons", "Huston", 13, "emmhuston@aol.com", "EN", "", "El Salvador");
INSERT INTO User VALUES (92, "Wood", "Cannon", 75, "woocannon@mail.ru", "EN", "", "Saint Lucia");
INSERT INTO User VALUES (93, "Kade", "Pena", 15, "kadpena@sbcglobal.net", "ES", "", "San Marino");
INSERT INTO User VALUES (94, "Nunzio", "Flint", 24, "nunflint@yahoo.com", "ES", "", "Argentina");
INSERT INTO User VALUES (95, "Athena", "Bergeron", 91, "athbergeron@yahoo.com", "EN", "", "Sudan");
INSERT INTO User VALUES (96, "Junior", "Hinojosa", 40, "junhinojosa@sbcglobal.net", "ES", "", "Saint Barthelemy");
INSERT INTO User VALUES (97, "Cleve", "Mabry", 63, "clemabry@aol.com", "ES", "", "India");
INSERT INTO User VALUES (98, "Cordella", "Thorne", 82, "corthorne@sbcglobal.net", "EN", "", "Estonia");
INSERT INTO User VALUES (99, "Holland", "Blake", 48, "holblake@hotmail.com", "EN", "", "West Bank");
INSERT INTO User VALUES (100, "Salina", "Sterling", 43, "salsterling@hotmail.com", "EN", "", "Virgin Islands");
INSERT INTO User VALUES (101, "Dale", "Butcher", 57, "dalbutcher@yahoo.com", "ES", "", "Azerbaijan");
INSERT INTO User VALUES (102, "Tandy", "Abernathy", 31, "tanabernathy@mail.ru", "EN", "", "Liberia");
INSERT INTO User VALUES (103, "Dejon", "Schneider", 71, "dejschneider@yahoo.com", "ES", "", "Austria");
INSERT INTO User VALUES (104, "Estell", "Upton", 13, "estupton@gmail.com", "ES", "", "Gibraltar");
INSERT INTO User VALUES (105, "Jaden", "Mcmullen", 74, "jadmcmullen@aol.com", "EN", "", "United Kingdom");
INSERT INTO User VALUES (106, "Genesis", "Lockwood", 16, "genlockwood@aol.com", "ES", "", "American Samoa");
INSERT INTO User VALUES (107, "Kyle", "Russ", 33, "kylruss@mail.ru", "EN", "", "Azerbaijan");
INSERT INTO User VALUES (108, "Norman", "Machado", 19, "normachado@yahoo.com", "ES", "", "Belarus");
INSERT INTO User VALUES (109, "Ashtyn", "Lam", 23, "ashlam@gmail.com", "ES", "", "Micronesia, Federated States of");
INSERT INTO User VALUES (110, "Malissa", "Worley", 84, "malworley@aol.com", "ES", "", "New Caledonia");
INSERT INTO User VALUES (111, "Belinda", "Bliss", 57, "belbliss@yahoo.com", "ES", "", "Chad");
INSERT INTO User VALUES (112, "Markel", "Sloan", 90, "marsloan@aol.com", "EN", "", "Cayman Islands");
INSERT INTO User VALUES (113, "Desiree", "Flint", 52, "desflint@hotmail.com", "ES", "", "Iran");
INSERT INTO User VALUES (114, "Berdie", "Lang", 31, "berlang@yahoo.com", "EN", "", "Argentina");
INSERT INTO User VALUES (115, "Lauretta", "Holloway", 57, "lauholloway@mail.ru", "EN", "", "Austria");
INSERT INTO User VALUES (116, "Fredy", "Bradford", 54, "frebradford@aol.com", "EN", "", "Jordan");
INSERT INTO User VALUES (117, "Jaliyah", "Akers", 85, "jalakers@facebook.com", "ES", "", "Chad");
INSERT INTO User VALUES (118, "Travis", "Swartz", 49, "traswartz@gmail.com", "ES", "", "Brazil");
INSERT INTO User VALUES (119, "Arbie", "Begay", 49, "arbbegay@mail.ru", "EN", "", "Palmyra Atoll");
INSERT INTO User VALUES (120, "Roland", "Abraham", 51, "rolabraham@facebook.com", "ES", "", "Egypt");
INSERT INTO User VALUES (121, "Dellia", "Odell", 18, "delodell@hotmail.com", "ES", "", "Zimbabwe");
INSERT INTO User VALUES (122, "Susanne", "Bourgeois", 29, "susbourgeois@hotmail.com", "ES", "", "Ireland");
INSERT INTO User VALUES (123, "Janel", "Moody", 31, "janmoody@facebook.com", "ES", "", "British Indian Ocean Territory");
INSERT INTO User VALUES (124, "Elaina", "Rubio", 25, "elarubio@aol.com", "ES", "", "Grenada");
INSERT INTO User VALUES (125, "Keenen", "Roark", 39, "keeroark@yahoo.com", "EN", "", "Uganda");
INSERT INTO User VALUES (126, "Zelda", "Booth", 17, "zelbooth@aol.com", "ES", "", "United States");
INSERT INTO User VALUES (127, "Allisson", "Doty", 76, "alldoty@gmail.com", "EN", "", "Lithuania");
INSERT INTO User VALUES (128, "Orville", "Bateman", 84, "orvbateman@gmail.com", "ES", "", "Singapore");
INSERT INTO User VALUES (129, "Julissa", "Salinas", 32, "julsalinas@mail.ru", "ES", "", "Anguilla");
INSERT INTO User VALUES (130, "Elsa", "Michel", 37, "elsmichel@yahoo.com", "ES", "", "Greenland");
INSERT INTO User VALUES (131, "Lori", "Doran", 18, "lordoran@aol.com", "EN", "", "Jan Mayen");
INSERT INTO User VALUES (132, "Schley", "Sandoval", 18, "schsandoval@sbcglobal.net", "ES", "", "Costa Rica");
INSERT INTO User VALUES (133, "Murl", "Ponce", 48, "murponce@facebook.com", "ES", "", "Holy See (Vatican City)");
INSERT INTO User VALUES (134, "Bynum", "Major", 35, "bynmajor@facebook.com", "EN", "", "Thailand");
INSERT INTO User VALUES (135, "Rube", "Cannon", 67, "rubcannon@hotmail.com", "EN", "", "Afghanistan");
INSERT INTO User VALUES (136, "Garth", "Dillard", 45, "gardillard@yahoo.com", "EN", "", "Botswana");
INSERT INTO User VALUES (137, "Bryan", "Dillon", 21, "brydillon@aol.com", "ES", "", "Saint Martin");
INSERT INTO User VALUES (138, "Boone", "Farrell", 72, "boofarrell@facebook.com", "ES", "", "Dhekelia");
INSERT INTO User VALUES (139, "Ingrid", "Coles", 19, "ingcoles@mail.ru", "ES", "", "Mexico");
INSERT INTO User VALUES (140, "Joline", "Upton", 74, "jolupton@hotmail.com", "ES", "", "Kosovo");
INSERT INTO User VALUES (141, "Brogan", "Masters", 46, "bromasters@mail.ru", "ES", "", "Maldives");
INSERT INTO User VALUES (142, "Armando", "Easley", 85, "armeasley@mail.ru", "EN", "", "Curacao");
INSERT INTO User VALUES (143, "Nigel", "Carlton", 23, "nigcarlton@hotmail.com", "EN", "", "Greece");
INSERT INTO User VALUES (144, "Ardith", "Fry", 85, "ardfry@aol.com", "ES", "", "Akrotiri");
INSERT INTO User VALUES (145, "Lucero", "Parks", 87, "lucparks@sbcglobal.net", "ES", "", "Lesotho");
INSERT INTO User VALUES (146, "Milford", "Ricks", 58, "milricks@mail.ru", "ES", "", "American Samoa");
INSERT INTO User VALUES (147, "Lollie", "Hightower", 57, "lolhightower@yahoo.com", "EN", "", "Cote d'Ivoire");
INSERT INTO User VALUES (148, "Marguerite", "Hinojosa", 71, "marhinojosa@gmail.com", "EN", "", "Cayman Islands");
INSERT INTO User VALUES (149, "Tara", "Valdez", 51, "tarvaldez@aol.com", "EN", "", "Cayman Islands");
INSERT INTO User VALUES (150, "Fleeta", "Cordova", 16, "flecordova@facebook.com", "EN", "", "El Salvador");
INSERT INTO User VALUES (151, "Kian", "Leach", 79, "kialeach@aol.com", "EN", "", "Montenegro");
INSERT INTO User VALUES (152, "Joanna", "Creech", 18, "joacreech@hotmail.com", "ES", "", "Liberia");
INSERT INTO User VALUES (153, "Rubye", "Gill", 33, "rubgill@yahoo.com", "EN", "", "Vietnam");
INSERT INTO User VALUES (154, "Jalisa", "Paul", 91, "jalpaul@aol.com", "ES", "", "Nauru");
INSERT INTO User VALUES (155, "Salome", "Mercer", 39, "salmercer@yahoo.com", "ES", "", "Suriname");
INSERT INTO User VALUES (156, "Budd", "Lockwood", 14, "budlockwood@gmail.com", "ES", "", "Qatar");
INSERT INTO User VALUES (157, "Kathleen", "Pearson", 17, "katpearson@facebook.com", "EN", "", "Saint Martin");
INSERT INTO User VALUES (158, "Jessi", "Youngblood", 45, "jesyoungblood@hotmail.com", "EN", "", "Zimbabwe");
INSERT INTO User VALUES (159, "Moises", "Lyles", 78, "moilyles@aol.com", "ES", "", "Antarctica");
INSERT INTO User VALUES (160, "Maribeth", "Wang", 42, "marwang@facebook.com", "ES", "", "United States");
INSERT INTO User VALUES (161, "Maybell", "Hancock", 83, "mayhancock@yahoo.com", "ES", "", "Tajikistan");
INSERT INTO User VALUES (162, "Ignatius", "Gale", 41, "igngale@hotmail.com", "ES", "", "Sudan");
INSERT INTO User VALUES (163, "Daisy", "Pool", 68, "daipool@aol.com", "EN", "", "Thailand");
INSERT INTO User VALUES (164, "Rodger", "Santiago", 60, "rodsantiago@aol.com", "ES", "", "Akrotiri");
INSERT INTO User VALUES (165, "Wilton", "Roman", 48, "wilroman@aol.com", "EN", "", "Barbados");
INSERT INTO User VALUES (166, "Blanchie", "Hooker", 19, "blahooker@mail.ru", "EN", "", "Malaysia");
INSERT INTO User VALUES (167, "Vicy", "Kimbrough", 55, "vickimbrough@aol.com", "EN", "", "Poland");
INSERT INTO User VALUES (168, "Bethann", "Irvin", 56, "betirvin@aol.com", "ES", "", "Fiji");
INSERT INTO User VALUES (169, "Jeremie", "Fugate", 22, "jerfugate@gmail.com", "EN", "", "Argentina");
INSERT INTO User VALUES (170, "Tolbert", "Milligan", 61, "tolmilligan@yahoo.com", "EN", "", "Estonia");
INSERT INTO User VALUES (171, "Ardyce", "Cummins", 63, "ardcummins@yahoo.com", "ES", "", "Peru");
INSERT INTO User VALUES (172, "Caitlyn", "Zavala", 71, "caizavala@yahoo.com", "EN", "", "Fiji");
INSERT INTO User VALUES (173, "Terri", "Ramirez", 58, "terramirez@yahoo.com", "ES", "", "Eritrea");
INSERT INTO User VALUES (174, "Randell", "Estes", 33, "ranestes@yahoo.com", "EN", "", "Western Sahara");
INSERT INTO User VALUES (175, "Anton", "Wang", 90, "antwang@yahoo.com", "ES", "", "United States");
INSERT INTO User VALUES (176, "Jenny", "Mason", 84, "jenmason@sbcglobal.net", "EN", "", "Belize");
INSERT INTO User VALUES (177, "Albina", "Hinojosa", 86, "albhinojosa@sbcglobal.net", "ES", "", "Mongolia");
INSERT INTO User VALUES (178, "Gladyce", "Ragsdale", 30, "glaragsdale@aol.com", "EN", "", "Monaco");
INSERT INTO User VALUES (179, "Iesha", "Higginbotham", 60, "ieshigginbotham@facebook.com", "EN", "", "Botswana");
INSERT INTO User VALUES (180, "Randal", "Blackmon", 23, "ranblackmon@hotmail.com", "EN", "", "Korea, North");
INSERT INTO User VALUES (181, "Maggie", "Tatum", 40, "magtatum@yahoo.com", "ES", "", "Indonesia");
INSERT INTO User VALUES (182, "Tyra", "Anderson", 53, "tyranderson@gmail.com", "ES", "", "Marshall Islands");
INSERT INTO User VALUES (183, "Assunta", "Akins", 28, "assakins@aol.com", "EN", "", "Nepal");
INSERT INTO User VALUES (184, "Cornel", "Ramsey", 92, "corramsey@facebook.com", "ES", "", "Liechtenstein");
INSERT INTO User VALUES (185, "Carsen", "Tanner", 39, "cartanner@yahoo.com", "EN", "", "Mauritius");
INSERT INTO User VALUES (186, "Corda", "Willey", 65, "corwilley@hotmail.com", "EN", "", "Austria");
INSERT INTO User VALUES (187, "Winton", "Holt", 67, "winholt@facebook.com", "ES", "", "Philippines");
INSERT INTO User VALUES (188, "Authur", "Otto", 21, "autotto@sbcglobal.net", "EN", "", "Haiti");
INSERT INTO User VALUES (189, "Deanna", "Kraft", 19, "deakraft@sbcglobal.net", "EN", "", "Panama");
INSERT INTO User VALUES (190, "Fidelia", "Weiss", 26, "fidweiss@yahoo.com", "EN", "", "Moldova");
INSERT INTO User VALUES (191, "Michell", "Schroeder", 78, "micschroeder@yahoo.com", "ES", "", "Madagascar");
INSERT INTO User VALUES (192, "Kyson", "Busch", 38, "kysbusch@aol.com", "EN", "", "West Bank");
INSERT INTO User VALUES (193, "Filomena", "Dowdy", 73, "fildowdy@aol.com", "ES", "", "Solomon Islands");
INSERT INTO User VALUES (194, "Sibyl", "Sumner", 52, "sibsumner@yahoo.com", "ES", "", "Burundi");
INSERT INTO User VALUES (195, "Lupe", "Bowser", 41, "lupbowser@aol.com", "ES", "", "Russia");
INSERT INTO User VALUES (196, "Marissa", "Moss", 52, "marmoss@mail.ru", "EN", "", "Algeria");
INSERT INTO User VALUES (197, "Dorla", "Cotton", 53, "dorcotton@yahoo.com", "EN", "", "British Indian Ocean Territory");
INSERT INTO User VALUES (198, "Sada", "Gill", 19, "sadgill@aol.com", "ES", "", "Oman");
INSERT INTO User VALUES (199, "Aurora", "Stark", 92, "aurstark@hotmail.com", "EN", "", "Mexico");
INSERT INTO User VALUES (200, "Randall", "Gates", 33, "rangates@yahoo.com", "EN", "", "Uruguay");
INSERT INTO User VALUES (201, "Kyson", "Hull", 60, "kyshull@yahoo.com", "EN", "", "Austria");
INSERT INTO User VALUES (202, "Wilfred", "Crews", 75, "wilcrews@gmail.com", "EN", "", "Palau");
INSERT INTO User VALUES (203, "Kenji", "Knox", 49, "kenknox@gmail.com", "ES", "", "Serbia");
INSERT INTO User VALUES (204, "Stevie", "Traylor", 63, "stetraylor@aol.com", "ES", "", "Equatorial Guinea");
INSERT INTO User VALUES (205, "Russ", "Mock", 83, "rusmock@sbcglobal.net", "EN", "", "Swaziland");
INSERT INTO User VALUES (206, "Jerrilyn", "Ruffin", 53, "jerruffin@hotmail.com", "EN", "", "Johnston Atoll");
INSERT INTO User VALUES (207, "Romeo", "Murphy", 33, "rommurphy@aol.com", "EN", "", "Sri Lanka");
INSERT INTO User VALUES (208, "Magdalene", "Michaels", 91, "magmichaels@gmail.com", "EN", "", "Cook Islands");
INSERT INTO User VALUES (209, "Captain", "Carrier", 66, "capcarrier@aol.com", "EN", "", "Mali");
INSERT INTO User VALUES (210, "Lasonya", "Osborn", 32, "lasosborn@sbcglobal.net", "EN", "", "Taiwan");
INSERT INTO User VALUES (211, "Sean", "Reilly", 86, "seareilly@mail.ru", "ES", "", "Afghanistan");
INSERT INTO User VALUES (212, "Jacques", "Medrano", 16, "jacmedrano@sbcglobal.net", "EN", "", "Iraq");
INSERT INTO User VALUES (213, "Ayden", "Elliot", 61, "aydelliot@mail.ru", "ES", "", "Uganda");
INSERT INTO User VALUES (214, "Alycia", "Lyles", 49, "alylyles@gmail.com", "EN", "", "Yemen");
INSERT INTO User VALUES (215, "Freida", "Crook", 89, "frecrook@gmail.com", "EN", "", "Saint Martin");
INSERT INTO User VALUES (216, "Abram", "Mott", 73, "abrmott@sbcglobal.net", "EN", "", "Micronesia, Federated States of");
INSERT INTO User VALUES (217, "Autumn", "Orozco", 92, "autorozco@aol.com", "EN", "", "Saint Pierre and Miquelon");
INSERT INTO User VALUES (218, "Jarett", "Portillo", 70, "jarportillo@aol.com", "EN", "", "Switzerland");
INSERT INTO User VALUES (219, "Napoleon", "Bruner", 64, "napbruner@aol.com", "EN", "", "Botswana");
INSERT INTO User VALUES (220, "Raphael", "Nickerson", 30, "rapnickerson@yahoo.com", "ES", "", "Tonga");
INSERT INTO User VALUES (221, "Catrina", "Lehman", 15, "catlehman@mail.ru", "EN", "", "Peru");
INSERT INTO User VALUES (222, "Shavon", "Fisher", 18, "shafisher@yahoo.com", "ES", "", "Fiji");
INSERT INTO User VALUES (223, "Lelah", "Thomas", 55, "lelthomas@hotmail.com", "EN", "", "Antigua and Barbuda");
INSERT INTO User VALUES (224, "Suzie", "Mckenzie", 22, "suzmckenzie@facebook.com", "EN", "", "Qatar");
INSERT INTO User VALUES (225, "Dedric", "Hand", 47, "dedhand@aol.com", "EN", "", "Italy");
INSERT INTO User VALUES (226, "Novella", "Broussard", 39, "novbroussard@facebook.com", "EN", "", "Ghana");
INSERT INTO User VALUES (227, "Dicy", "Eckert", 24, "diceckert@mail.ru", "ES", "", "Angola");
INSERT INTO User VALUES (228, "Mekhi", "Dodson", 22, "mekdodson@yahoo.com", "EN", "", "Benin");
INSERT INTO User VALUES (229, "Landen", "Storey", 76, "lanstorey@yahoo.com", "ES", "", "Romania");
INSERT INTO User VALUES (230, "Alvira", "Patten", 57, "alvpatten@yahoo.com", "EN", "", "Sri Lanka");
INSERT INTO User VALUES (231, "Sharita", "Buckner", 40, "shabuckner@facebook.com", "EN", "", "Mozambique");
INSERT INTO User VALUES (232, "Kira", "Carson", 51, "kircarson@facebook.com", "ES", "", "Niger");
INSERT INTO User VALUES (233, "Wes", "Hall", 56, "weshall@gmail.com", "ES", "", "Anguilla");
INSERT INTO User VALUES (234, "Eldridge", "Gardner", 17, "eldgardner@hotmail.com", "ES", "", "Latvia");
INSERT INTO User VALUES (235, "Lucy", "Gunter", 40, "lucgunter@facebook.com", "EN", "", "Comoros");
INSERT INTO User VALUES (236, "Lindbergh", "Villanueva", 66, "linvillanueva@sbcglobal.net", "ES", "", "India");
INSERT INTO User VALUES (237, "Terrell", "Iverson", 29, "teriverson@gmail.com", "ES", "", "Estonia");
INSERT INTO User VALUES (238, "Belton", "Hurst", 20, "belhurst@hotmail.com", "ES", "", "Algeria");
INSERT INTO User VALUES (239, "Bruce", "Dodd", 40, "brudodd@sbcglobal.net", "ES", "", "Korea, North");
INSERT INTO User VALUES (240, "Willis", "Kent", 60, "wilkent@facebook.com", "EN", "", "Ethiopia");
INSERT INTO User VALUES (241, "Melony", "Romo", 50, "melromo@facebook.com", "ES", "", "Heard Island and McDonald Islands");
INSERT INTO User VALUES (242, "Lucile", "Daly", 80, "lucdaly@yahoo.com", "ES", "", "Cocos (Keeling) Islands");
INSERT INTO User VALUES (243, "Alda", "Stern", 22, "aldstern@hotmail.com", "ES", "", "Mauritania");
INSERT INTO User VALUES (244, "Elmore", "Russ", 20, "elmruss@aol.com", "ES", "", "Curacao");
INSERT INTO User VALUES (245, "Che", "Morrison", 35, "chemorrison@gmail.com", "EN", "", "Eritrea");
INSERT INTO User VALUES (246, "Rory", "Cote", 36, "rorcote@sbcglobal.net", "ES", "", "Luxembourg");
INSERT INTO User VALUES (247, "Mariah", "Levine", 38, "marlevine@aol.com", "EN", "", "Kazakhstan");
INSERT INTO User VALUES (248, "Hampton", "Hickey", 47, "hamhickey@aol.com", "EN", "", "Niue");
INSERT INTO User VALUES (249, "Shawnte", "Kline", 88, "shakline@facebook.com", "ES", "", "Pakistan");

INSERT INTO connection VALUES (74, 9, '2010-12-17');
INSERT INTO connection VALUES (9, 74, '2010-12-17');
INSERT INTO connection VALUES (206, 28, '2015-2-11');
INSERT INTO connection VALUES (28, 206, '2015-2-11');
INSERT INTO connection VALUES (233, 74, '2012-11-24');
INSERT INTO connection VALUES (74, 233, '2012-11-24');
INSERT INTO connection VALUES (1, 219, '2013-5-23');
INSERT INTO connection VALUES (219, 1, '2013-5-23');
INSERT INTO connection VALUES (13, 17, '2012-4-17');
INSERT INTO connection VALUES (17, 13, '2012-4-17');
INSERT INTO connection VALUES (81, 249, '2012-10-24');
INSERT INTO connection VALUES (249, 81, '2012-10-24');
INSERT INTO connection VALUES (78, 16, '2011-2-28');
INSERT INTO connection VALUES (16, 78, '2011-2-28');
INSERT INTO connection VALUES (112, 38, '2011-12-16');
INSERT INTO connection VALUES (38, 112, '2011-12-16');
INSERT INTO connection VALUES (67, 59, '2015-9-2');
INSERT INTO connection VALUES (59, 67, '2015-9-2');
INSERT INTO connection VALUES (188, 25, '2015-9-25');
INSERT INTO connection VALUES (25, 188, '2015-9-25');
INSERT INTO connection VALUES (189, 111, '2013-9-6');
INSERT INTO connection VALUES (111, 189, '2013-9-6');
INSERT INTO connection VALUES (121, 27, '2014-9-13');
INSERT INTO connection VALUES (27, 121, '2014-9-13');
INSERT INTO connection VALUES (92, 206, '2010-6-17');
INSERT INTO connection VALUES (206, 92, '2010-6-17');
INSERT INTO connection VALUES (216, 14, '2015-9-8');
INSERT INTO connection VALUES (14, 216, '2015-9-8');
INSERT INTO connection VALUES (66, 12, '2016-10-12');
INSERT INTO connection VALUES (12, 66, '2016-10-12');
INSERT INTO connection VALUES (47, 231, '2015-6-19');
INSERT INTO connection VALUES (231, 47, '2015-6-19');
INSERT INTO connection VALUES (222, 61, '2015-12-9');
INSERT INTO connection VALUES (61, 222, '2015-12-9');
INSERT INTO connection VALUES (239, 8, '2010-9-10');
INSERT INTO connection VALUES (8, 239, '2010-9-10');
INSERT INTO connection VALUES (96, 34, '2015-6-9');
INSERT INTO connection VALUES (34, 96, '2015-6-9');
INSERT INTO connection VALUES (142, 241, '2016-9-17');
INSERT INTO connection VALUES (241, 142, '2016-9-17');
INSERT INTO connection VALUES (9, 127, '2013-12-12');
INSERT INTO connection VALUES (127, 9, '2013-12-12');
INSERT INTO connection VALUES (164, 217, '2011-6-6');
INSERT INTO connection VALUES (217, 164, '2011-6-6');
INSERT INTO connection VALUES (157, 48, '2017-11-4');
INSERT INTO connection VALUES (48, 157, '2017-11-4');
INSERT INTO connection VALUES (75, 79, '2016-5-9');
INSERT INTO connection VALUES (79, 75, '2016-5-9');
INSERT INTO connection VALUES (188, 75, '2010-1-10');
INSERT INTO connection VALUES (75, 188, '2010-1-10');
INSERT INTO connection VALUES (5, 35, '2017-1-9');
INSERT INTO connection VALUES (35, 5, '2017-1-9');
INSERT INTO connection VALUES (138, 191, '2014-4-29');
INSERT INTO connection VALUES (191, 138, '2014-4-29');
INSERT INTO connection VALUES (187, 36, '2016-4-26');
INSERT INTO connection VALUES (36, 187, '2016-4-26');
INSERT INTO connection VALUES (85, 23, '2013-6-20');
INSERT INTO connection VALUES (23, 85, '2013-6-20');
INSERT INTO connection VALUES (54, 40, '2010-4-25');
INSERT INTO connection VALUES (40, 54, '2010-4-25');
INSERT INTO connection VALUES (206, 160, '2012-10-3');
INSERT INTO connection VALUES (160, 206, '2012-10-3');
INSERT INTO connection VALUES (61, 45, '2017-4-7');
INSERT INTO connection VALUES (45, 61, '2017-4-7');
INSERT INTO connection VALUES (109, 196, '2017-11-18');
INSERT INTO connection VALUES (196, 109, '2017-11-18');
INSERT INTO connection VALUES (152, 164, '2013-3-12');
INSERT INTO connection VALUES (164, 152, '2013-3-12');
INSERT INTO connection VALUES (225, 32, '2013-12-11');
INSERT INTO connection VALUES (32, 225, '2013-12-11');
INSERT INTO connection VALUES (84, 145, '2016-5-19');
INSERT INTO connection VALUES (145, 84, '2016-5-19');
INSERT INTO connection VALUES (76, 235, '2011-8-22');
INSERT INTO connection VALUES (235, 76, '2011-8-22');
INSERT INTO connection VALUES (18, 41, '2011-12-17');
INSERT INTO connection VALUES (41, 18, '2011-12-17');
INSERT INTO connection VALUES (54, 243, '2011-10-2');
INSERT INTO connection VALUES (243, 54, '2011-10-2');
INSERT INTO connection VALUES (149, 158, '2010-3-3');
INSERT INTO connection VALUES (158, 149, '2010-3-3');
INSERT INTO connection VALUES (236, 12, '2013-6-17');
INSERT INTO connection VALUES (12, 236, '2013-6-17');
INSERT INTO connection VALUES (108, 174, '2014-3-1');
INSERT INTO connection VALUES (174, 108, '2014-3-1');
INSERT INTO connection VALUES (223, 166, '2017-6-15');
INSERT INTO connection VALUES (166, 223, '2017-6-15');
INSERT INTO connection VALUES (167, 132, '2013-3-19');
INSERT INTO connection VALUES (132, 167, '2013-3-19');
INSERT INTO connection VALUES (149, 38, '2013-5-7');
INSERT INTO connection VALUES (38, 149, '2013-5-7');
INSERT INTO connection VALUES (68, 111, '2016-11-30');
INSERT INTO connection VALUES (111, 68, '2016-11-30');
INSERT INTO connection VALUES (30, 189, '2015-7-6');
INSERT INTO connection VALUES (189, 30, '2015-7-6');
INSERT INTO connection VALUES (79, 141, '2011-12-16');
INSERT INTO connection VALUES (141, 79, '2011-12-16');
INSERT INTO connection VALUES (123, 217, '2014-1-23');
INSERT INTO connection VALUES (217, 123, '2014-1-23');
INSERT INTO connection VALUES (128, 118, '2016-12-6');
INSERT INTO connection VALUES (118, 128, '2016-12-6');
INSERT INTO connection VALUES (61, 110, '2011-5-28');
INSERT INTO connection VALUES (110, 61, '2011-5-28');
INSERT INTO connection VALUES (184, 138, '2013-1-6');
INSERT INTO connection VALUES (138, 184, '2013-1-6');
INSERT INTO connection VALUES (159, 250, '2014-11-17');
INSERT INTO connection VALUES (250, 159, '2014-11-17');
INSERT INTO connection VALUES (10, 123, '2012-1-26');
INSERT INTO connection VALUES (123, 10, '2012-1-26');
INSERT INTO connection VALUES (135, 217, '2014-6-21');
INSERT INTO connection VALUES (217, 135, '2014-6-21');
INSERT INTO connection VALUES (195, 62, '2012-4-21');
INSERT INTO connection VALUES (62, 195, '2012-4-21');
INSERT INTO connection VALUES (121, 1, '2014-9-26');
INSERT INTO connection VALUES (1, 121, '2014-9-26');
INSERT INTO connection VALUES (6, 190, '2011-1-11');
INSERT INTO connection VALUES (190, 6, '2011-1-11');
INSERT INTO connection VALUES (96, 115, '2015-7-26');
INSERT INTO connection VALUES (115, 96, '2015-7-26');
INSERT INTO connection VALUES (112, 222, '2014-10-9');
INSERT INTO connection VALUES (222, 112, '2014-10-9');
INSERT INTO connection VALUES (11, 6, '2012-6-11');
INSERT INTO connection VALUES (6, 11, '2012-6-11');
INSERT INTO connection VALUES (204, 22, '2013-4-5');
INSERT INTO connection VALUES (22, 204, '2013-4-5');
INSERT INTO connection VALUES (68, 61, '2014-7-6');
INSERT INTO connection VALUES (61, 68, '2014-7-6');
INSERT INTO connection VALUES (220, 157, '2014-4-11');
INSERT INTO connection VALUES (157, 220, '2014-4-11');
INSERT INTO connection VALUES (248, 141, '2011-11-15');
INSERT INTO connection VALUES (141, 248, '2011-11-15');
INSERT INTO connection VALUES (231, 186, '2010-6-28');
INSERT INTO connection VALUES (186, 231, '2010-6-28');
INSERT INTO connection VALUES (172, 25, '2015-2-3');
INSERT INTO connection VALUES (25, 172, '2015-2-3');
INSERT INTO connection VALUES (234, 226, '2016-1-19');
INSERT INTO connection VALUES (226, 234, '2016-1-19');
INSERT INTO connection VALUES (178, 173, '2012-5-20');
INSERT INTO connection VALUES (173, 178, '2012-5-20');
INSERT INTO connection VALUES (43, 182, '2016-5-27');
INSERT INTO connection VALUES (182, 43, '2016-5-27');
INSERT INTO connection VALUES (78, 5, '2014-2-2');
INSERT INTO connection VALUES (5, 78, '2014-2-2');
INSERT INTO connection VALUES (180, 44, '2013-7-14');
INSERT INTO connection VALUES (44, 180, '2013-7-14');
INSERT INTO connection VALUES (26, 59, '2017-11-27');
INSERT INTO connection VALUES (59, 26, '2017-11-27');
INSERT INTO connection VALUES (21, 158, '2016-2-12');
INSERT INTO connection VALUES (158, 21, '2016-2-12');
INSERT INTO connection VALUES (139, 178, '2016-11-2');
INSERT INTO connection VALUES (178, 139, '2016-11-2');
INSERT INTO connection VALUES (147, 148, '2012-12-3');
INSERT INTO connection VALUES (148, 147, '2012-12-3');
INSERT INTO connection VALUES (35, 182, '2012-5-2');
INSERT INTO connection VALUES (182, 35, '2012-5-2');
INSERT INTO connection VALUES (90, 152, '2014-12-1');
INSERT INTO connection VALUES (152, 90, '2014-12-1');
INSERT INTO connection VALUES (157, 45, '2017-8-15');
INSERT INTO connection VALUES (45, 157, '2017-8-15');
INSERT INTO connection VALUES (174, 85, '2010-6-13');
INSERT INTO connection VALUES (85, 174, '2010-6-13');
INSERT INTO connection VALUES (228, 138, '2013-1-18');
INSERT INTO connection VALUES (138, 228, '2013-1-18');
INSERT INTO connection VALUES (185, 178, '2012-4-22');
INSERT INTO connection VALUES (178, 185, '2012-4-22');
INSERT INTO connection VALUES (137, 179, '2016-4-16');
INSERT INTO connection VALUES (179, 137, '2016-4-16');
INSERT INTO connection VALUES (178, 80, '2016-6-3');
INSERT INTO connection VALUES (80, 178, '2016-6-3');
INSERT INTO connection VALUES (201, 116, '2014-8-10');
INSERT INTO connection VALUES (116, 201, '2014-8-10');
INSERT INTO connection VALUES (113, 236, '2017-7-27');
INSERT INTO connection VALUES (236, 113, '2017-7-27');
INSERT INTO connection VALUES (198, 50, '2010-1-18');
INSERT INTO connection VALUES (50, 198, '2010-1-18');
INSERT INTO connection VALUES (16, 234, '2011-12-23');
INSERT INTO connection VALUES (234, 16, '2011-12-23');
INSERT INTO connection VALUES (15, 176, '2016-11-3');
INSERT INTO connection VALUES (176, 15, '2016-11-3');
INSERT INTO connection VALUES (100, 181, '2013-11-12');
INSERT INTO connection VALUES (181, 100, '2013-11-12');
INSERT INTO connection VALUES (27, 177, '2012-11-20');
INSERT INTO connection VALUES (177, 27, '2012-11-20');
INSERT INTO connection VALUES (16, 68, '2010-10-18');
INSERT INTO connection VALUES (68, 16, '2010-10-18');
INSERT INTO connection VALUES (172, 203, '2012-7-8');
INSERT INTO connection VALUES (203, 172, '2012-7-8');
INSERT INTO connection VALUES (85, 172, '2010-5-25');
INSERT INTO connection VALUES (172, 85, '2010-5-25');
INSERT INTO connection VALUES (12, 84, '2012-6-11');
INSERT INTO connection VALUES (84, 12, '2012-6-11');
INSERT INTO connection VALUES (61, 23, '2010-6-17');
INSERT INTO connection VALUES (23, 61, '2010-6-17');
INSERT INTO connection VALUES (20, 173, '2012-2-2');
INSERT INTO connection VALUES (173, 20, '2012-2-2');
INSERT INTO connection VALUES (138, 167, '2012-3-18');
INSERT INTO connection VALUES (167, 138, '2012-3-18');
INSERT INTO connection VALUES (176, 97, '2016-10-22');
INSERT INTO connection VALUES (97, 176, '2016-10-22');
INSERT INTO connection VALUES (143, 78, '2011-3-21');
INSERT INTO connection VALUES (78, 143, '2011-3-21');


INSERT INTO Boundaries VALUES("Afghanistan", "China", 91);
INSERT INTO Boundaries VALUES("Afghanistan", "Iran", 921);
INSERT INTO Boundaries VALUES("Afghanistan", "Pakistan", 2670);
INSERT INTO Boundaries VALUES("Afghanistan", "Tajikistan", 1357);
INSERT INTO Boundaries VALUES("Afghanistan", "Turkmenistan", 804);
INSERT INTO Boundaries VALUES("Afghanistan", "Uzbekistan", 144);
INSERT INTO Boundaries VALUES("Akrotiri", "Cyprus", 48);
INSERT INTO Boundaries VALUES("Albania", "Greece", 212);
INSERT INTO Boundaries VALUES("Albania", "Kosovo", 112);
INSERT INTO Boundaries VALUES("Albania", "Macedonia", 181);
INSERT INTO Boundaries VALUES("Albania", "Montenegro", 186);
INSERT INTO Boundaries VALUES("Algeria", "Libya", 989);
INSERT INTO Boundaries VALUES("Algeria", "Mali", 1359);
INSERT INTO Boundaries VALUES("Algeria", "Mauritania", 460);
INSERT INTO Boundaries VALUES("Algeria", "Morocco", 1900);
INSERT INTO Boundaries VALUES("Algeria", "Niger", 951);
INSERT INTO Boundaries VALUES("Algeria", "Tunisia", 1034);
INSERT INTO Boundaries VALUES("Algeria", "Western Sahara", 41);
INSERT INTO Boundaries VALUES("Andorra", "France", 55);
INSERT INTO Boundaries VALUES("Andorra", "Spain", 63);
INSERT INTO Boundaries VALUES("Angola", "Democratic Republic of the Congo", 2646);
INSERT INTO Boundaries VALUES("Angola", "Republic of the Congo", 231);
INSERT INTO Boundaries VALUES("Angola", "Namibia", 1427);
INSERT INTO Boundaries VALUES("Angola", "Zambia", 1065);
INSERT INTO Boundaries VALUES("Argentina", "Bolivia", 942);
INSERT INTO Boundaries VALUES("Argentina", "Brazil", 1263);
INSERT INTO Boundaries VALUES("Argentina", "Chile", 6691);
INSERT INTO Boundaries VALUES("Argentina", "Paraguay", 2531);
INSERT INTO Boundaries VALUES("Argentina", "Uruguay", 541);
INSERT INTO Boundaries VALUES("Armenia", "Azerbaijan", 996);
INSERT INTO Boundaries VALUES("Armenia", "Georgia", 219);
INSERT INTO Boundaries VALUES("Armenia", "Iran", 44);
INSERT INTO Boundaries VALUES("Armenia", "Turkey", 311);
INSERT INTO Boundaries VALUES("Austria", "Czech Republic", 402);
INSERT INTO Boundaries VALUES("Austria", "Germany", 801);
INSERT INTO Boundaries VALUES("Austria", "Hungary", 321);
INSERT INTO Boundaries VALUES("Austria", "Italy", 404);
INSERT INTO Boundaries VALUES("Austria", "Liechtenstein", 34);
INSERT INTO Boundaries VALUES("Austria", "Slovakia", 105);
INSERT INTO Boundaries VALUES("Austria", "Slovenia", 299);
INSERT INTO Boundaries VALUES("Austria", "Switzerland", 158);
INSERT INTO Boundaries VALUES("Azerbaijan", "Armenia", 996);
INSERT INTO Boundaries VALUES("Azerbaijan", "Georgia", 428);
INSERT INTO Boundaries VALUES("Azerbaijan", "Iran", 689);
INSERT INTO Boundaries VALUES("Azerbaijan", "Russia", 338);
INSERT INTO Boundaries VALUES("Azerbaijan", "Turkey", 17);
INSERT INTO Boundaries VALUES("Bangladesh", "Burma", 271);
INSERT INTO Boundaries VALUES("Bangladesh", "India", 4142);
INSERT INTO Boundaries VALUES("Belarus", "Latvia", 161);
INSERT INTO Boundaries VALUES("Belarus", "Lithuania", 640);
INSERT INTO Boundaries VALUES("Belarus", "Poland", 375);
INSERT INTO Boundaries VALUES("Belarus", "Russia", 1312);
INSERT INTO Boundaries VALUES("Belarus", "Ukraine", 1111);
INSERT INTO Boundaries VALUES("Belgium", "France", 556);
INSERT INTO Boundaries VALUES("Belgium", "Germany", 133);
INSERT INTO Boundaries VALUES("Belgium", "Luxembourg", 130);
INSERT INTO Boundaries VALUES("Belgium", "Netherlands", 478);
INSERT INTO Boundaries VALUES("Belize", "Guatemala", 266);
INSERT INTO Boundaries VALUES("Belize", "Mexico", 276);
INSERT INTO Boundaries VALUES("Benin", "Burkina Faso", 386);
INSERT INTO Boundaries VALUES("Benin", "Niger", 277);
INSERT INTO Boundaries VALUES("Benin", "Nigeria", 809);
INSERT INTO Boundaries VALUES("Benin", "Togo", 651);
INSERT INTO Boundaries VALUES("Bhutan", "China", 477);
INSERT INTO Boundaries VALUES("Bhutan", "India", 659);
INSERT INTO Boundaries VALUES("Bolivia", "Argentina", 942);
INSERT INTO Boundaries VALUES("Bolivia", "Brazil", 3403);
INSERT INTO Boundaries VALUES("Bolivia", "Chile", 942);
INSERT INTO Boundaries VALUES("Bolivia", "Paraguay", 753);
INSERT INTO Boundaries VALUES("Bolivia", "Peru", 1212);
INSERT INTO Boundaries VALUES("Bosnia and Herzegovina", "Croatia", 956);
INSERT INTO Boundaries VALUES("Bosnia and Herzegovina", "Montenegro", 242);
INSERT INTO Boundaries VALUES("Bosnia and Herzegovina", "Serbia", 345);
INSERT INTO Boundaries VALUES("Botswana", "Namibia", 1544);
INSERT INTO Boundaries VALUES("Botswana", "South Africa", 1969);
INSERT INTO Boundaries VALUES("Botswana", "Zambia", 0.1);
INSERT INTO Boundaries VALUES("Botswana", "Zimbabwe", 834);
INSERT INTO Boundaries VALUES("Brazil", "Argentina", 1263);
INSERT INTO Boundaries VALUES("Brazil", "Bolivia", 3403);
INSERT INTO Boundaries VALUES("Brazil", "Colombia", 1790);
INSERT INTO Boundaries VALUES("Brazil", "French Guiana", 649);
INSERT INTO Boundaries VALUES("Brazil", "Guyana", 1308);
INSERT INTO Boundaries VALUES("Brazil", "Paraguay", 1371);
INSERT INTO Boundaries VALUES("Brazil", "Peru", 2659);
INSERT INTO Boundaries VALUES("Brazil", "Suriname", 515);
INSERT INTO Boundaries VALUES("Brazil", "Uruguay", 1050);
INSERT INTO Boundaries VALUES("Brazil", "Venezuela", 2137);
INSERT INTO Boundaries VALUES("Brunei", "Malaysia", 266);
INSERT INTO Boundaries VALUES("Bulgaria", "Greece", 472);
INSERT INTO Boundaries VALUES("Bulgaria", "Macedonia", 162);
INSERT INTO Boundaries VALUES("Bulgaria", "Romania", 605);
INSERT INTO Boundaries VALUES("Bulgaria", "Serbia", 344);
INSERT INTO Boundaries VALUES("Bulgaria", "Turkey", 223);
INSERT INTO Boundaries VALUES("Burkina Faso", "Benin", 386);
INSERT INTO Boundaries VALUES("Burkina Faso", "Cote d'Ivoire", 545);
INSERT INTO Boundaries VALUES("Burkina Faso", "Ghana", 602);
INSERT INTO Boundaries VALUES("Burkina Faso", "Mali", 1325);
INSERT INTO Boundaries VALUES("Burkina Faso", "Niger", 622);
INSERT INTO Boundaries VALUES("Burkina Faso", "Togo", 131);
INSERT INTO Boundaries VALUES("Burma", "Bangladesh", 271);
INSERT INTO Boundaries VALUES("Burma", "China", 2129);
INSERT INTO Boundaries VALUES("Burma", "India", 1468);
INSERT INTO Boundaries VALUES("Burma", "Laos", 238);
INSERT INTO Boundaries VALUES("Burma", "Thailand", 2416);
INSERT INTO Boundaries VALUES("Burundi", "Democratic Republic of the Congo", 236);
INSERT INTO Boundaries VALUES("Burundi", "Rwanda", 315);
INSERT INTO Boundaries VALUES("Burundi", "Tanzania", 589);
INSERT INTO Boundaries VALUES("Cambodia", "Laos", 555);
INSERT INTO Boundaries VALUES("Cambodia", "Thailand", 817);
INSERT INTO Boundaries VALUES("Cambodia", "Vietnam", 1158);
INSERT INTO Boundaries VALUES("Cameroon", "Central African Republic", 901);
INSERT INTO Boundaries VALUES("Cameroon", "Chad", 1116);
INSERT INTO Boundaries VALUES("Cameroon", "Republic of the Congo", 494);
INSERT INTO Boundaries VALUES("Cameroon", "Equatorial Guinea", 183);
INSERT INTO Boundaries VALUES("Cameroon", "Gabon", 349);
INSERT INTO Boundaries VALUES("Cameroon", "Nigeria", 1975);
INSERT INTO Boundaries VALUES("Canada", "US", 8893);
INSERT INTO Boundaries VALUES("Central African Republic", "Cameroon", 901);
INSERT INTO Boundaries VALUES("Central African Republic", "Chad", 1556);
INSERT INTO Boundaries VALUES("Central African Republic", "Democratic Republic of the Congo", 1747);
INSERT INTO Boundaries VALUES("Central African Republic", "Republic of the Congo", 487);
INSERT INTO Boundaries VALUES("Central African Republic", "South Sudan", 1055);
INSERT INTO Boundaries VALUES("Central African Republic", "Sudan", 174);
INSERT INTO Boundaries VALUES("Chad", "Cameroon", 1116);
INSERT INTO Boundaries VALUES("Chad", "Central African Republic", 1556);
INSERT INTO Boundaries VALUES("Chad", "Libya", 1050);
INSERT INTO Boundaries VALUES("Chad", "Niger", 1196);
INSERT INTO Boundaries VALUES("Chad", "Nigeria", 85);
INSERT INTO Boundaries VALUES("Chad", "Sudan", 1403);
INSERT INTO Boundaries VALUES("Chile", "Argentina", 6691);
INSERT INTO Boundaries VALUES("Chile", "Bolivia", 942);
INSERT INTO Boundaries VALUES("Chile", "Peru", 168);
INSERT INTO Boundaries VALUES("China", "Afghanistan", 91);
INSERT INTO Boundaries VALUES("China", "Bhutan", 477);
INSERT INTO Boundaries VALUES("China", "Burma", 2129);
INSERT INTO Boundaries VALUES("China", "India", 2659);
INSERT INTO Boundaries VALUES("China", "Kazakhstan", 1765);
INSERT INTO Boundaries VALUES("China", "North Korea", 1352);
INSERT INTO Boundaries VALUES("China", "Kyrgyzstan", 1063);
INSERT INTO Boundaries VALUES("China", "Laos", 475);
INSERT INTO Boundaries VALUES("China", "Mongolia", 4630);
INSERT INTO Boundaries VALUES("China", "Nepal", 1389);
INSERT INTO Boundaries VALUES("China", "Pakistan", 438);
INSERT INTO Boundaries VALUES("China", "Russia", 4139);
INSERT INTO Boundaries VALUES("China", "Tajikistan", 477);
INSERT INTO Boundaries VALUES("China", "Vietnam", 1297);
INSERT INTO Boundaries VALUES("Colombia", "Brazil", 1790);
INSERT INTO Boundaries VALUES("Colombia", "Ecuador", 708);
INSERT INTO Boundaries VALUES("Colombia", "Panama", 339);
INSERT INTO Boundaries VALUES("Colombia", "Peru", 1494);
INSERT INTO Boundaries VALUES("Colombia", "Venezuela", 2341);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Angola", 2646);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Burundi", 236);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Central African Republic", 1747);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Republic of the Congo", 1229);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Rwanda", 221);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "South Sudan", 714);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Tanzania", 479);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Uganda", 877);
INSERT INTO Boundaries VALUES("Congo, Democratic Republic of the", "Zambia", 2332);
INSERT INTO Boundaries VALUES("Congo, Republic of the", "Angola", 231);
INSERT INTO Boundaries VALUES("Congo, Republic of the", "Cameroon", 494);
INSERT INTO Boundaries VALUES("Congo, Republic of the", "Central African Republic", 487);
INSERT INTO Boundaries VALUES("Congo, Republic of the", "Democratic Republic of the Congo", 1229);
INSERT INTO Boundaries VALUES("Congo, Republic of the", "Gabon", 2567);
INSERT INTO Boundaries VALUES("Costa Rica", "Nicaragua", 313);
INSERT INTO Boundaries VALUES("Costa Rica", "Panama", 348);
INSERT INTO Boundaries VALUES("Cote d'Ivoire", "Burkina Faso", 545);
INSERT INTO Boundaries VALUES("Cote d'Ivoire", "Ghana", 720);
INSERT INTO Boundaries VALUES("Cote d'Ivoire", "Guinea", 816);
INSERT INTO Boundaries VALUES("Cote d'Ivoire", "Liberia", 778);
INSERT INTO Boundaries VALUES("Cote d'Ivoire", "Mali", 599);
INSERT INTO Boundaries VALUES("Croatia", "Bosnia and Herzegovina", 956);
INSERT INTO Boundaries VALUES("Croatia", "Hungary", 348);
INSERT INTO Boundaries VALUES("Croatia", "Montenegro", 19);
INSERT INTO Boundaries VALUES("Croatia", "Serbia", 314);
INSERT INTO Boundaries VALUES("Croatia", "Slovenia", 600);
INSERT INTO Boundaries VALUES("Cuba", "US Naval Base at Guantanamo Bay", 29);
INSERT INTO Boundaries VALUES("Cyprus", "Akrotiri", 48);
INSERT INTO Boundaries VALUES("Cyprus", "Dhekelia", 108);
INSERT INTO Boundaries VALUES("Czech Republic", "Austria", 402);
INSERT INTO Boundaries VALUES("Czech Republic", "Germany", 704);
INSERT INTO Boundaries VALUES("Czech Republic", "Poland", 699);
INSERT INTO Boundaries VALUES("Czech Republic", "Slovakia", 241);
INSERT INTO Boundaries VALUES("Denmark", "Germany", 140);
INSERT INTO Boundaries VALUES("Dhekelia", "Cyprus", 108);
INSERT INTO Boundaries VALUES("Djibouti", "Eritrea", 125);
INSERT INTO Boundaries VALUES("Djibouti", "Ethiopia", 342);
INSERT INTO Boundaries VALUES("Djibouti", "Somalia", 61);
INSERT INTO Boundaries VALUES("Dominican Republic", "Haiti", 376);
INSERT INTO Boundaries VALUES("Ecuador", "Colombia", 708);
INSERT INTO Boundaries VALUES("Ecuador", "Peru", 1529);
INSERT INTO Boundaries VALUES("Egypt", "Gaza Strip", 13);
INSERT INTO Boundaries VALUES("Egypt", "Israel", 208);
INSERT INTO Boundaries VALUES("Egypt", "Libya", 1115);
INSERT INTO Boundaries VALUES("Egypt", "Sudan", 1276);
INSERT INTO Boundaries VALUES("El Salvador", "Guatemala", 199);
INSERT INTO Boundaries VALUES("El Salvador", "Honduras", 391);
INSERT INTO Boundaries VALUES("Equatorial Guinea", "Cameroon", 183);
INSERT INTO Boundaries VALUES("Equatorial Guinea", "Gabon", 345);
INSERT INTO Boundaries VALUES("Eritrea", "Djibouti", 125);
INSERT INTO Boundaries VALUES("Eritrea", "Ethiopia", 1033);
INSERT INTO Boundaries VALUES("Eritrea", "Sudan", 682);
INSERT INTO Boundaries VALUES("Estonia", "Latvia", 333);
INSERT INTO Boundaries VALUES("Estonia", "Russia", 324);
INSERT INTO Boundaries VALUES("Ethiopia", "Djibouti", 342);
INSERT INTO Boundaries VALUES("Ethiopia", "Eritrea", 1033);
INSERT INTO Boundaries VALUES("Ethiopia", "Kenya", 867);
INSERT INTO Boundaries VALUES("Ethiopia", "Somalia", 1640);
INSERT INTO Boundaries VALUES("Ethiopia", "South Sudan", 1299);
INSERT INTO Boundaries VALUES("Ethiopia", "Sudan", 744);
INSERT INTO Boundaries VALUES("European Union", "Albania", 282);
INSERT INTO Boundaries VALUES("European Union", "Andorra", 120.3);
INSERT INTO Boundaries VALUES("European Union", "Belarus", 1050);
INSERT INTO Boundaries VALUES("European Union", "Croatia", 999);
INSERT INTO Boundaries VALUES("European Union", "Holy See", 3.2);
INSERT INTO Boundaries VALUES("European Union", "Liechtenstein", 34.9);
INSERT INTO Boundaries VALUES("European Union", "Macedonia", 394);
INSERT INTO Boundaries VALUES("European Union", "Moldova", 450);
INSERT INTO Boundaries VALUES("European Union", "Monaco", 4.4);
INSERT INTO Boundaries VALUES("European Union", "Norway", 2348);
INSERT INTO Boundaries VALUES("European Union", "Russia", 2257);
INSERT INTO Boundaries VALUES("European Union", "San Marino", 39);
INSERT INTO Boundaries VALUES("European Union", "Serbia", 945);
INSERT INTO Boundaries VALUES("European Union", "Switzerland", 1811);
INSERT INTO Boundaries VALUES("European Union", "Turkey", 446);
INSERT INTO Boundaries VALUES("European Union", "Ukraine", 1257);
INSERT INTO Boundaries VALUES("Finland", "Norway", 709);
INSERT INTO Boundaries VALUES("Finland", "Sweden", 545);
INSERT INTO Boundaries VALUES("Finland", "Russia", 1309);
INSERT INTO Boundaries VALUES("France", "Andorra", 55);
INSERT INTO Boundaries VALUES("France", "Belgium", 556);
INSERT INTO Boundaries VALUES("France", "Germany", 418);
INSERT INTO Boundaries VALUES("France", "Italy", 476);
INSERT INTO Boundaries VALUES("France", "Luxembourg", 69);
INSERT INTO Boundaries VALUES("France", "Monaco", 6);
INSERT INTO Boundaries VALUES("France", "Spain", 646);
INSERT INTO Boundaries VALUES("France", "Switzerland", 525);
INSERT INTO Boundaries VALUES("Gabon", "Cameroon", 349);
INSERT INTO Boundaries VALUES("Gabon", "Republic of the Congo", 2567);
INSERT INTO Boundaries VALUES("Gabon", "Equatorial Guinea", 345);
INSERT INTO Boundaries VALUES("Gambia, The", "Senegal", 749);
INSERT INTO Boundaries VALUES("Gaza Strip", "Egypt", 13);
INSERT INTO Boundaries VALUES("Gaza Strip", "Israel", 59);
INSERT INTO Boundaries VALUES("Georgia", "Armenia", 219);
INSERT INTO Boundaries VALUES("Georgia", "Azerbaijan", 428);
INSERT INTO Boundaries VALUES("Georgia", "Russia", 894);
INSERT INTO Boundaries VALUES("Georgia", "Turkey", 273);
INSERT INTO Boundaries VALUES("Germany", "Austria", 801);
INSERT INTO Boundaries VALUES("Germany", "Belgium", 133);
INSERT INTO Boundaries VALUES("Germany", "Czech Republic", 704);
INSERT INTO Boundaries VALUES("Germany", "Denmark", 140);
INSERT INTO Boundaries VALUES("Germany", "France", 418);
INSERT INTO Boundaries VALUES("Germany", "Luxembourg", 128);
INSERT INTO Boundaries VALUES("Germany", "Netherlands", 575);
INSERT INTO Boundaries VALUES("Germany", "Poland", 447);
INSERT INTO Boundaries VALUES("Germany", "Switzerland", 348);
INSERT INTO Boundaries VALUES("Ghana", "Burkina Faso", 602);
INSERT INTO Boundaries VALUES("Ghana", "Cote d'Ivoire", 720);
INSERT INTO Boundaries VALUES("Ghana", "Togo", 1098);
INSERT INTO Boundaries VALUES("Gibraltar", "Spain", 1);
INSERT INTO Boundaries VALUES("Greece", "Albania", 212);
INSERT INTO Boundaries VALUES("Greece", "Bulgaria", 472);
INSERT INTO Boundaries VALUES("Greece", "Macedonia", 234);
INSERT INTO Boundaries VALUES("Greece", "Turkey", 192);
INSERT INTO Boundaries VALUES("Guatemala", "Belize", 266);
INSERT INTO Boundaries VALUES("Guatemala", "El Salvador", 199);
INSERT INTO Boundaries VALUES("Guatemala", "Honduras", 244);
INSERT INTO Boundaries VALUES("Guatemala", "Mexico", 958);
INSERT INTO Boundaries VALUES("Guinea", "Cote d'Ivoire", 816);
INSERT INTO Boundaries VALUES("Guinea", "Guinea-Bissau", 421);
INSERT INTO Boundaries VALUES("Guinea", "Liberia", 590);
INSERT INTO Boundaries VALUES("Guinea", "Mali", 1062);
INSERT INTO Boundaries VALUES("Guinea", "Senegal", 363);
INSERT INTO Boundaries VALUES("Guinea", "Sierra Leone", 794);
INSERT INTO Boundaries VALUES("Guinea-Bissau", "Guinea", 421);
INSERT INTO Boundaries VALUES("Guinea-Bissau", "Senegal", 341);
INSERT INTO Boundaries VALUES("Guyana", "Brazil", 1308);
INSERT INTO Boundaries VALUES("Guyana", "Suriname", 836);
INSERT INTO Boundaries VALUES("Guyana", "Venezuela", 789);
INSERT INTO Boundaries VALUES("Haiti", "Dominican Republic", 376);
INSERT INTO Boundaries VALUES("Holy See", "Italy", 3);
INSERT INTO Boundaries VALUES("Honduras", "Guatemala", 244);
INSERT INTO Boundaries VALUES("Honduras", "El Salvador", 391);
INSERT INTO Boundaries VALUES("Honduras", "Nicaragua", 940);
INSERT INTO Boundaries VALUES("Hong Kong", "China", 33);
INSERT INTO Boundaries VALUES("Hungary", "Austria", 321);
INSERT INTO Boundaries VALUES("Hungary", "Croatia", 348);
INSERT INTO Boundaries VALUES("Hungary", "Romania", 424);
INSERT INTO Boundaries VALUES("Hungary", "Serbia", 164);
INSERT INTO Boundaries VALUES("Hungary", "Slovakia", 627);
INSERT INTO Boundaries VALUES("Hungary", "Slovenia", 94);
INSERT INTO Boundaries VALUES("Hungary", "Ukraine", 128);
INSERT INTO Boundaries VALUES("India", "Bangladesh", 4142);
INSERT INTO Boundaries VALUES("India", "Bhutan", 659);
INSERT INTO Boundaries VALUES("India", "Burma", 1468);
INSERT INTO Boundaries VALUES("India", "China", 2659);
INSERT INTO Boundaries VALUES("India", "Nepal", 1770);
INSERT INTO Boundaries VALUES("India", "Pakistan", 3190);
INSERT INTO Boundaries VALUES("Indonesia", "Timor-Leste", 253);
INSERT INTO Boundaries VALUES("Indonesia", "Malaysia", 1881);
INSERT INTO Boundaries VALUES("Indonesia", "Papua New Guinea", 824);
INSERT INTO Boundaries VALUES("Iran", "Afghanistan", 921);
INSERT INTO Boundaries VALUES("Iran", "Armenia", 44);
INSERT INTO Boundaries VALUES("Iran", "Azerbaijan", 689);
INSERT INTO Boundaries VALUES("Iran", "Iraq", 1599);
INSERT INTO Boundaries VALUES("Iran", "Pakistan", 959);
INSERT INTO Boundaries VALUES("Iran", "Turkey", 534);
INSERT INTO Boundaries VALUES("Iran", "Turkmenistan", 1148);
INSERT INTO Boundaries VALUES("Iraq", "Iran", 1599);
INSERT INTO Boundaries VALUES("Iraq", "Jordan", 179);
INSERT INTO Boundaries VALUES("Iraq", "Kuwait", 254);
INSERT INTO Boundaries VALUES("Iraq", "Saudi Arabia", 811);
INSERT INTO Boundaries VALUES("Iraq", "Syria", 599);
INSERT INTO Boundaries VALUES("Iraq", "Turkey", 367);
INSERT INTO Boundaries VALUES("Ireland", "UK", 443);
INSERT INTO Boundaries VALUES("Israel", "Egypt", 208);
INSERT INTO Boundaries VALUES("Israel", "Gaza Strip", 59);
INSERT INTO Boundaries VALUES("Israel", "Jordan", 307);
INSERT INTO Boundaries VALUES("Israel", "Lebanon", 81);
INSERT INTO Boundaries VALUES("Israel", "Syria", 83);
INSERT INTO Boundaries VALUES("Israel", "West Bank", 330);
INSERT INTO Boundaries VALUES("Italy", "Austria", 404);
INSERT INTO Boundaries VALUES("Italy", "France", 476);
INSERT INTO Boundaries VALUES("Italy", "Holy See", 3);
INSERT INTO Boundaries VALUES("Italy", "San Marino", 37);
INSERT INTO Boundaries VALUES("Italy", "Slovenia", 218);
INSERT INTO Boundaries VALUES("Italy", "Switzerland", 698);
INSERT INTO Boundaries VALUES("Jordan", "Iraq", 179);
INSERT INTO Boundaries VALUES("Jordan", "Israel", 307);
INSERT INTO Boundaries VALUES("Jordan", "Saudi Arabia", 731);
INSERT INTO Boundaries VALUES("Jordan", "Syria", 379);
INSERT INTO Boundaries VALUES("Jordan", "West Bank", 148);
INSERT INTO Boundaries VALUES("Kazakhstan", "China", 1765);
INSERT INTO Boundaries VALUES("Kazakhstan", "Kyrgyzstan", 1212);
INSERT INTO Boundaries VALUES("Kazakhstan", "Russia", 7644);
INSERT INTO Boundaries VALUES("Kazakhstan", "Turkmenistan", 413);
INSERT INTO Boundaries VALUES("Kazakhstan", "Uzbekistan", 2330);
INSERT INTO Boundaries VALUES("Kenya", "Ethiopia", 867);
INSERT INTO Boundaries VALUES("Kenya", "Somalia", 684);
INSERT INTO Boundaries VALUES("Kenya", "South Sudan", 317);
INSERT INTO Boundaries VALUES("Kenya", "Tanzania", 775);
INSERT INTO Boundaries VALUES("Kenya", "Uganda", 814);
INSERT INTO Boundaries VALUES("Korea, North", "China", 1352);
INSERT INTO Boundaries VALUES("Korea, North", "South Korea", 237);
INSERT INTO Boundaries VALUES("Korea, North", "Russia", 18);
INSERT INTO Boundaries VALUES("Korea, South", "North Korea", 237);
INSERT INTO Boundaries VALUES("Kosovo", "Albania", 112);
INSERT INTO Boundaries VALUES("Kosovo", "Macedonia", 160);
INSERT INTO Boundaries VALUES("Kosovo", "Montenegro", 76);
INSERT INTO Boundaries VALUES("Kosovo", "Serbia", 366);
INSERT INTO Boundaries VALUES("Kuwait", "Iraq", 254);
INSERT INTO Boundaries VALUES("Kuwait", "Saudi Arabia", 221);
INSERT INTO Boundaries VALUES("Kyrgyzstan", "China", 1063);
INSERT INTO Boundaries VALUES("Kyrgyzstan", "Kazakhstan", 1212);
INSERT INTO Boundaries VALUES("Kyrgyzstan", "Tajikistan", 984);
INSERT INTO Boundaries VALUES("Kyrgyzstan", "Uzbekistan", 1314);
INSERT INTO Boundaries VALUES("Laos", "Burma", 238);
INSERT INTO Boundaries VALUES("Laos", "Cambodia", 555);
INSERT INTO Boundaries VALUES("Laos", "China", 475);
INSERT INTO Boundaries VALUES("Laos", "Thailand", 1845);
INSERT INTO Boundaries VALUES("Laos", "Vietnam", 2161);
INSERT INTO Boundaries VALUES("Latvia", "Belarus", 161);
INSERT INTO Boundaries VALUES("Latvia", "Estonia", 333);
INSERT INTO Boundaries VALUES("Latvia", "Lithuania", 544);
INSERT INTO Boundaries VALUES("Latvia", "Russia", 332);
INSERT INTO Boundaries VALUES("Lebanon", "Israel", 81);
INSERT INTO Boundaries VALUES("Lebanon", "Syria", 403);
INSERT INTO Boundaries VALUES("Lesotho", "South Africa", 1106);
INSERT INTO Boundaries VALUES("Liberia", "Guinea", 590);
INSERT INTO Boundaries VALUES("Liberia", "Cote d'Ivoire", 778);
INSERT INTO Boundaries VALUES("Liberia", "Sierra Leone", 299);
INSERT INTO Boundaries VALUES("Libya", "Algeria", 989);
INSERT INTO Boundaries VALUES("Libya", "Chad", 1050);
INSERT INTO Boundaries VALUES("Libya", "Egypt", 1115);
INSERT INTO Boundaries VALUES("Libya", "Niger", 342);
INSERT INTO Boundaries VALUES("Libya", "Sudan", 382);
INSERT INTO Boundaries VALUES("Libya", "Tunisia", 461);
INSERT INTO Boundaries VALUES("Liechtenstein", "Austria", 34);
INSERT INTO Boundaries VALUES("Liechtenstein", "Switzerland", 41);
INSERT INTO Boundaries VALUES("Lithuania", "Belarus", 640);
INSERT INTO Boundaries VALUES("Lithuania", "Latvia", 544);
INSERT INTO Boundaries VALUES("Lithuania", "Poland", 100);
INSERT INTO Boundaries VALUES("Lithuania", "Russia", 261);
INSERT INTO Boundaries VALUES("Luxembourg", "Belgium", 130);
INSERT INTO Boundaries VALUES("Luxembourg", "France", 69);
INSERT INTO Boundaries VALUES("Luxembourg", "Germany", 128);
INSERT INTO Boundaries VALUES("Macau", "China", 3);
INSERT INTO Boundaries VALUES("Macedonia", "Albania", 181);
INSERT INTO Boundaries VALUES("Macedonia", "Bulgaria", 162);
INSERT INTO Boundaries VALUES("Macedonia", "Greece", 234);
INSERT INTO Boundaries VALUES("Macedonia", "Kosovo", 160);
INSERT INTO Boundaries VALUES("Macedonia", "Serbia", 101);
INSERT INTO Boundaries VALUES("Malawi", "Mozambique", 1498);
INSERT INTO Boundaries VALUES("Malawi", "Tanzania", 512);
INSERT INTO Boundaries VALUES("Malawi", "Zambia", 847);
INSERT INTO Boundaries VALUES("Malaysia", "Brunei", 266);
INSERT INTO Boundaries VALUES("Malaysia", "Indonesia", 1881);
INSERT INTO Boundaries VALUES("Malaysia", "Thailand", 595);
INSERT INTO Boundaries VALUES("Mali", "Algeria", 1359);
INSERT INTO Boundaries VALUES("Mali", "Burkina Faso", 1325);
INSERT INTO Boundaries VALUES("Mali", "Cote d'Ivoire", 599);
INSERT INTO Boundaries VALUES("Mali", "Guinea", 1062);
INSERT INTO Boundaries VALUES("Mali", "Mauritania", 2236);
INSERT INTO Boundaries VALUES("Mali", "Niger", 838);
INSERT INTO Boundaries VALUES("Mali", "Senegal", 489);
INSERT INTO Boundaries VALUES("Mauritania", "Algeria", 460);
INSERT INTO Boundaries VALUES("Mauritania", "Mali", 2236);
INSERT INTO Boundaries VALUES("Mauritania", "Senegal", 742);
INSERT INTO Boundaries VALUES("Mauritania", "Western Sahara", 1564);
INSERT INTO Boundaries VALUES("Mexico", "Belize", 276);
INSERT INTO Boundaries VALUES("Mexico", "Guatemala", 958);
INSERT INTO Boundaries VALUES("Mexico", "US", 3155);
INSERT INTO Boundaries VALUES("Moldova", "Romania", 683);
INSERT INTO Boundaries VALUES("Moldova", "Ukraine", 1202);
INSERT INTO Boundaries VALUES("Monaco", "France", 6);
INSERT INTO Boundaries VALUES("Mongolia", "China", 4630);
INSERT INTO Boundaries VALUES("Mongolia", "Russia", 3452);
INSERT INTO Boundaries VALUES("Montenegro", "Albania", 186);
INSERT INTO Boundaries VALUES("Montenegro", "Bosnia and Herzegovina", 242);
INSERT INTO Boundaries VALUES("Montenegro", "Croatia", 19);
INSERT INTO Boundaries VALUES("Montenegro", "Kosovo", 76);
INSERT INTO Boundaries VALUES("Montenegro", "Serbia", 157);
INSERT INTO Boundaries VALUES("Morocco", "Algeria", 1900);
INSERT INTO Boundaries VALUES("Morocco", "Western Sahara", 444);
INSERT INTO Boundaries VALUES("Morocco", "Spain", 8);
INSERT INTO Boundaries VALUES("Mozambique", "Malawi", 1498);
INSERT INTO Boundaries VALUES("Mozambique", "South Africa", 496);
INSERT INTO Boundaries VALUES("Mozambique", "Swaziland", 108);
INSERT INTO Boundaries VALUES("Mozambique", "Tanzania", 840);
INSERT INTO Boundaries VALUES("Mozambique", "Zambia", 439);
INSERT INTO Boundaries VALUES("Mozambique", "Zimbabwe", 1402);
INSERT INTO Boundaries VALUES("Namibia", "Angola", 1427);
INSERT INTO Boundaries VALUES("Namibia", "Botswana", 1544);
INSERT INTO Boundaries VALUES("Namibia", "South Africa", 1005);
INSERT INTO Boundaries VALUES("Namibia", "Zambia", 244);
INSERT INTO Boundaries VALUES("Nepal", "China", 1389);
INSERT INTO Boundaries VALUES("Nepal", "India", 1770);
INSERT INTO Boundaries VALUES("Netherlands", "Belgium", 478);
INSERT INTO Boundaries VALUES("Netherlands", "Germany", 575);
INSERT INTO Boundaries VALUES("Nicaragua", "Costa Rica", 313);
INSERT INTO Boundaries VALUES("Nicaragua", "Honduras", 940);
INSERT INTO Boundaries VALUES("Niger", "Algeria", 951);
INSERT INTO Boundaries VALUES("Niger", "Benin", 277);
INSERT INTO Boundaries VALUES("Niger", "Burkina Faso", 622);
INSERT INTO Boundaries VALUES("Niger", "Chad", 1196);
INSERT INTO Boundaries VALUES("Niger", "Libya", 342);
INSERT INTO Boundaries VALUES("Niger", "Mali", 838);
INSERT INTO Boundaries VALUES("Niger", "Nigeria", 1608);
INSERT INTO Boundaries VALUES("Nigeria", "Benin", 809);
INSERT INTO Boundaries VALUES("Nigeria", "Cameroon", 1975);
INSERT INTO Boundaries VALUES("Nigeria", "Chad", 85);
INSERT INTO Boundaries VALUES("Nigeria", "Niger", 1608);
INSERT INTO Boundaries VALUES("Norway", "Finland", 709);
INSERT INTO Boundaries VALUES("Norway", "Sweden", 1666);
INSERT INTO Boundaries VALUES("Norway", "Russia", 191);
INSERT INTO Boundaries VALUES("Oman", "Saudi Arabia", 658);
INSERT INTO Boundaries VALUES("Oman", "UAE", 609);
INSERT INTO Boundaries VALUES("Oman", "Yemen", 294);
INSERT INTO Boundaries VALUES("Pakistan", "Afghanistan", 2670);
INSERT INTO Boundaries VALUES("Pakistan", "China", 438);
INSERT INTO Boundaries VALUES("Pakistan", "India", 3190);
INSERT INTO Boundaries VALUES("Pakistan", "Iran", 959);
INSERT INTO Boundaries VALUES("Panama", "Colombia", 339);
INSERT INTO Boundaries VALUES("Panama", "Costa Rica", 348);
INSERT INTO Boundaries VALUES("Papua New Guinea", "Indonesia", 824);
INSERT INTO Boundaries VALUES("Paraguay", "Argentina", 2531);
INSERT INTO Boundaries VALUES("Paraguay", "Bolivia", 753);
INSERT INTO Boundaries VALUES("Paraguay", "Brazil", 1371);
INSERT INTO Boundaries VALUES("Peru", "Bolivia", 1212);
INSERT INTO Boundaries VALUES("Peru", "Brazil", 2659);
INSERT INTO Boundaries VALUES("Peru", "Chile", 168);
INSERT INTO Boundaries VALUES("Peru", "Colombia", 1494);
INSERT INTO Boundaries VALUES("Peru", "Ecuador", 1529);
INSERT INTO Boundaries VALUES("Poland", "Belarus", 375);
INSERT INTO Boundaries VALUES("Poland", "Czech Republic", 699);
INSERT INTO Boundaries VALUES("Poland", "Germany", 447);
INSERT INTO Boundaries VALUES("Poland", "Lithuania", 100);
INSERT INTO Boundaries VALUES("Poland", "Russia", 209);
INSERT INTO Boundaries VALUES("Poland", "Slovakia", 517);
INSERT INTO Boundaries VALUES("Poland", "Ukraine", 498);
INSERT INTO Boundaries VALUES("Portugal", "Spain", 1224);
INSERT INTO Boundaries VALUES("Qatar", "Saudi Arabia", 87);
INSERT INTO Boundaries VALUES("Romania", "Bulgaria", 605);
INSERT INTO Boundaries VALUES("Romania", "Hungary", 424);
INSERT INTO Boundaries VALUES("Romania", "Moldova", 683);
INSERT INTO Boundaries VALUES("Romania", "Serbia", 531);
INSERT INTO Boundaries VALUES("Romania", "Ukraine", 601);
INSERT INTO Boundaries VALUES("Russia", "Azerbaijan", 338);
INSERT INTO Boundaries VALUES("Russia", "Belarus", 1312);
INSERT INTO Boundaries VALUES("Russia", "China", 4133);
INSERT INTO Boundaries VALUES("Russia", "Estonia", 324);
INSERT INTO Boundaries VALUES("Russia", "Finland", 1309);
INSERT INTO Boundaries VALUES("Russia", "Georgia", 894);
INSERT INTO Boundaries VALUES("Russia", "Kazakhstan", 7644);
INSERT INTO Boundaries VALUES("Russia", "North Korea", 18);
INSERT INTO Boundaries VALUES("Russia", "Latvia", 332);
INSERT INTO Boundaries VALUES("Russia", "Lithuania", 261);
INSERT INTO Boundaries VALUES("Russia", "Mongolia", 3452);
INSERT INTO Boundaries VALUES("Russia", "Norway", 191);
INSERT INTO Boundaries VALUES("Russia", "Poland", 209);
INSERT INTO Boundaries VALUES("Russia", "Ukraine", 1944);
INSERT INTO Boundaries VALUES("Rwanda", "Burundi", 315);
INSERT INTO Boundaries VALUES("Rwanda", "Democratic Republic of the Congo", 221);
INSERT INTO Boundaries VALUES("Rwanda", "Tanzania", 222);
INSERT INTO Boundaries VALUES("Rwanda", "Uganda", 172);
INSERT INTO Boundaries VALUES("Saint Martin", "Sint Maarten", 16);
INSERT INTO Boundaries VALUES("San Marino", "Italy", 37);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Iraq", 811);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Jordan", 731);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Kuwait", 221);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Oman", 658);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Qatar", 87);
INSERT INTO Boundaries VALUES("Saudi Arabia", "UAE", 457);
INSERT INTO Boundaries VALUES("Saudi Arabia", "Yemen", 1307);
INSERT INTO Boundaries VALUES("Senegal", "The Gambia", 749);
INSERT INTO Boundaries VALUES("Senegal", "Guinea", 363);
INSERT INTO Boundaries VALUES("Senegal", "Guinea-Bissau", 341);
INSERT INTO Boundaries VALUES("Senegal", "Mali", 489);
INSERT INTO Boundaries VALUES("Senegal", "Mauritania", 742);
INSERT INTO Boundaries VALUES("Serbia", "Bosnia and Herzegovina", 345);
INSERT INTO Boundaries VALUES("Serbia", "Bulgaria", 344);
INSERT INTO Boundaries VALUES("Serbia", "Croatia", 314);
INSERT INTO Boundaries VALUES("Serbia", "Hungary", 164);
INSERT INTO Boundaries VALUES("Serbia", "Kosovo", 366);
INSERT INTO Boundaries VALUES("Serbia", "Macedonia", 101);
INSERT INTO Boundaries VALUES("Serbia", "Montenegro", 157);
INSERT INTO Boundaries VALUES("Serbia", "Romania", 531);
INSERT INTO Boundaries VALUES("Sierra Leone", "Guinea", 794);
INSERT INTO Boundaries VALUES("Sierra Leone", "Liberia", 299);
INSERT INTO Boundaries VALUES("Sint Maarten", "Saint Martin", 16);
INSERT INTO Boundaries VALUES("Slovakia", "Austria", 105);
INSERT INTO Boundaries VALUES("Slovakia", "Czech Republic", 241);
INSERT INTO Boundaries VALUES("Slovakia", "Hungary", 627);
INSERT INTO Boundaries VALUES("Slovakia", "Poland", 517);
INSERT INTO Boundaries VALUES("Slovakia", "Ukraine", 97);
INSERT INTO Boundaries VALUES("Slovenia", "Austria", 299);
INSERT INTO Boundaries VALUES("Slovenia", "Croatia", 600);
INSERT INTO Boundaries VALUES("Slovenia", "Hungary", 94);
INSERT INTO Boundaries VALUES("Slovenia", "Italy", 218);
INSERT INTO Boundaries VALUES("Somalia", "Djibouti", 61);
INSERT INTO Boundaries VALUES("Somalia", "Ethiopia", 1640);
INSERT INTO Boundaries VALUES("Somalia", "Kenya", 684);
INSERT INTO Boundaries VALUES("South Africa", "Botswana", 1969);
INSERT INTO Boundaries VALUES("South Africa", "Lesotho", 1106);
INSERT INTO Boundaries VALUES("South Africa", "Mozambique", 496);
INSERT INTO Boundaries VALUES("South Africa", "Namibia", 1005);
INSERT INTO Boundaries VALUES("South Africa", "Swaziland", 438);
INSERT INTO Boundaries VALUES("South Africa", "Zimbabwe", 230);
INSERT INTO Boundaries VALUES("South Sudan", "Central African Republic", 1055);
INSERT INTO Boundaries VALUES("South Sudan", "Democratic Republic of the Congo", 714);
INSERT INTO Boundaries VALUES("South Sudan", "Ethiopia", 1299);
INSERT INTO Boundaries VALUES("South Sudan", "Kenya", 317);
INSERT INTO Boundaries VALUES("South Sudan", "Sudan", 2158);
INSERT INTO Boundaries VALUES("South Sudan", "Uganda", 475);
INSERT INTO Boundaries VALUES("Spain", "Andorra", 63);
INSERT INTO Boundaries VALUES("Spain", "France", 646);
INSERT INTO Boundaries VALUES("Spain", "Gibraltar", 1);
INSERT INTO Boundaries VALUES("Spain", "Portugal", 1224);
INSERT INTO Boundaries VALUES("Spain", "Morocco", 8);
INSERT INTO Boundaries VALUES("Sudan", "Central African Republic", 174);
INSERT INTO Boundaries VALUES("Sudan", "Chad", 1403);
INSERT INTO Boundaries VALUES("Sudan", "Egypt", 1276);
INSERT INTO Boundaries VALUES("Sudan", "Eritrea", 682);
INSERT INTO Boundaries VALUES("Sudan", "Ethiopia", 744);
INSERT INTO Boundaries VALUES("Sudan", "Libya", 382);
INSERT INTO Boundaries VALUES("Sudan", "South Sudan", 2158);
INSERT INTO Boundaries VALUES("Suriname", "Brazil", 515);
INSERT INTO Boundaries VALUES("Suriname", "French Guiana", 556);
INSERT INTO Boundaries VALUES("Suriname", "Guyana", 836);
INSERT INTO Boundaries VALUES("Swaziland", "Mozambique", 108);
INSERT INTO Boundaries VALUES("Swaziland", "South Africa", 438);
INSERT INTO Boundaries VALUES("Sweden", "Finland", 545);
INSERT INTO Boundaries VALUES("Sweden", "Norway", 1666);
INSERT INTO Boundaries VALUES("Switzerland", "Austria", 158);
INSERT INTO Boundaries VALUES("Switzerland", "France", 525);
INSERT INTO Boundaries VALUES("Switzerland", "Italy", 698);
INSERT INTO Boundaries VALUES("Switzerland", "Liechtenstein", 41);
INSERT INTO Boundaries VALUES("Switzerland", "Germany", 348);
INSERT INTO Boundaries VALUES("Syria", "Iraq", 599);
INSERT INTO Boundaries VALUES("Syria", "Israel", 83);
INSERT INTO Boundaries VALUES("Syria", "Jordan", 379);
INSERT INTO Boundaries VALUES("Syria", "Lebanon", 403);
INSERT INTO Boundaries VALUES("Syria", "Turkey", 899);
INSERT INTO Boundaries VALUES("Tajikistan", "Afghanistan", 1357);
INSERT INTO Boundaries VALUES("Tajikistan", "China", 477);
INSERT INTO Boundaries VALUES("Tajikistan", "Kyrgyzstan", 984);
INSERT INTO Boundaries VALUES("Tajikistan", "Uzbekistan", 1312);
INSERT INTO Boundaries VALUES("Tanzania", "Burundi", 589);
INSERT INTO Boundaries VALUES("Tanzania", "Democratic Republic of the Congo", 479);
INSERT INTO Boundaries VALUES("Tanzania", "Kenya", 775);
INSERT INTO Boundaries VALUES("Tanzania", "Malawi", 512);
INSERT INTO Boundaries VALUES("Tanzania", "Mozambique", 840);
INSERT INTO Boundaries VALUES("Tanzania", "Rwanda", 222);
INSERT INTO Boundaries VALUES("Tanzania", "Uganda", 391);
INSERT INTO Boundaries VALUES("Tanzania", "Zambia", 353);
INSERT INTO Boundaries VALUES("Thailand", "Burma", 2416);
INSERT INTO Boundaries VALUES("Thailand", "Cambodia", 817);
INSERT INTO Boundaries VALUES("Thailand", "Laos", 1845);
INSERT INTO Boundaries VALUES("Thailand", "Malaysia", 595);
INSERT INTO Boundaries VALUES("Timor-Leste", "Indonesia", 253);
INSERT INTO Boundaries VALUES("Togo", "Benin", 651);
INSERT INTO Boundaries VALUES("Togo", "Burkina Faso", 131);
INSERT INTO Boundaries VALUES("Togo", "Ghana", 1098);
INSERT INTO Boundaries VALUES("Tunisia", "Algeria", 1034);
INSERT INTO Boundaries VALUES("Tunisia", "Libya", 461);
INSERT INTO Boundaries VALUES("Turkey", "Armenia", 311);
INSERT INTO Boundaries VALUES("Turkey", "Azerbaijan", 17);
INSERT INTO Boundaries VALUES("Turkey", "Bulgaria", 223);
INSERT INTO Boundaries VALUES("Turkey", "Georgia", 273);
INSERT INTO Boundaries VALUES("Turkey", "Greece", 192);
INSERT INTO Boundaries VALUES("Turkey", "Iran", 534);
INSERT INTO Boundaries VALUES("Turkey", "Iraq", 367);
INSERT INTO Boundaries VALUES("Turkey", "Syria", 899);
INSERT INTO Boundaries VALUES("Turkmenistan", "Afghanistan", 804);
INSERT INTO Boundaries VALUES("Turkmenistan", "Iran", 1148);
INSERT INTO Boundaries VALUES("Turkmenistan", "Kazakhstan", 413);
INSERT INTO Boundaries VALUES("Turkmenistan", "Uzbekistan", 1793);
INSERT INTO Boundaries VALUES("Uganda", "Democratic Republic of the Congo", 877);
INSERT INTO Boundaries VALUES("Uganda", "Kenya", 814);
INSERT INTO Boundaries VALUES("Uganda", "Rwanda", 172);
INSERT INTO Boundaries VALUES("Uganda", "South Sudan", 475);
INSERT INTO Boundaries VALUES("Uganda", "Tanzania", 391);
INSERT INTO Boundaries VALUES("Ukraine", "Belarus", 1111);
INSERT INTO Boundaries VALUES("Ukraine", "Hungary", 128);
INSERT INTO Boundaries VALUES("Ukraine", "Moldova", 1202);
INSERT INTO Boundaries VALUES("Ukraine", "Poland", 498);
INSERT INTO Boundaries VALUES("Ukraine", "Romania", 601);
INSERT INTO Boundaries VALUES("Ukraine", "Russia", 1944);
INSERT INTO Boundaries VALUES("Ukraine", "Slovakia", 97);
INSERT INTO Boundaries VALUES("United Arab Emirates", "Oman", 609);
INSERT INTO Boundaries VALUES("United Arab Emirates", "Saudi Arabia", 457);
INSERT INTO Boundaries VALUES("United Kingdom", "Ireland", 443);
INSERT INTO Boundaries VALUES("United States", "Canada", 8893);
INSERT INTO Boundaries VALUES("United States", "Mexico", 3155);
INSERT INTO Boundaries VALUES("Uruguay", "Argentina", 541);
INSERT INTO Boundaries VALUES("Uruguay", "Brazil", 1050);
INSERT INTO Boundaries VALUES("Uzbekistan", "Afghanistan", 144);
INSERT INTO Boundaries VALUES("Uzbekistan", "Kazakhstan", 2330);
INSERT INTO Boundaries VALUES("Uzbekistan", "Kyrgyzstan", 1314);
INSERT INTO Boundaries VALUES("Uzbekistan", "Tajikistan", 1312);
INSERT INTO Boundaries VALUES("Uzbekistan", "Turkmenistan", 1793);
INSERT INTO Boundaries VALUES("Venezuela", "Brazil", 2137);
INSERT INTO Boundaries VALUES("Venezuela", "Colombia", 2341);
INSERT INTO Boundaries VALUES("Venezuela", "Guyana", 789);
INSERT INTO Boundaries VALUES("Vietnam", "Cambodia", 1158);
INSERT INTO Boundaries VALUES("Vietnam", "China", 1297);
INSERT INTO Boundaries VALUES("Vietnam", "Laos", 2161);
INSERT INTO Boundaries VALUES("West Bank", "Israel", 330);
INSERT INTO Boundaries VALUES("West Bank", "Jordan", 148);
INSERT INTO Boundaries VALUES("Western Sahara", "Algeria", 41);
INSERT INTO Boundaries VALUES("Western Sahara", "Mauritania", 1564);
INSERT INTO Boundaries VALUES("Western Sahara", "Morocco", 444);
INSERT INTO Boundaries VALUES("Yemen", "Oman", 294);
INSERT INTO Boundaries VALUES("Yemen", "Saudi Arabia", 1307);
INSERT INTO Boundaries VALUES("Zambia", "Angola", 1065);
INSERT INTO Boundaries VALUES("Zambia", "Botswana", 0.1);
INSERT INTO Boundaries VALUES("Zambia", "Democratic Republic of the Congo", 2332);
INSERT INTO Boundaries VALUES("Zambia", "Malawi", 847);
INSERT INTO Boundaries VALUES("Zambia", "Mozambique", 439);
INSERT INTO Boundaries VALUES("Zambia", "Namibia", 244);
INSERT INTO Boundaries VALUES("Zambia", "Tanzania", 353);
INSERT INTO Boundaries VALUES("Zambia", "Zimbabwe", 763);
INSERT INTO Boundaries VALUES("Zimbabwe", "Botswana", 834);
INSERT INTO Boundaries VALUES("Zimbabwe", "Mozambique", 1402);
INSERT INTO Boundaries VALUES("Zimbabwe", "South Africa", 230);
INSERT INTO Boundaries VALUES("Zimbabwe", "Zambia", 763);

INSERT INTO Languages VALUES(0, "Dari", "Afghanistan", 50);
INSERT INTO Languages VALUES(1, "Pashto", "Afghanistan", 35);
INSERT INTO Languages(id, name, country) VALUES(2, "English", "Akrot");
INSERT INTO Languages(id, name, country) VALUES(3, "Greek", "Akrot");
INSERT INTO Languages VALUES(4, "Albanian", "Albania", 98.8);
INSERT INTO Languages VALUES(5, "Greek", "Albania", 0.5);
INSERT INTO Languages(id, name, country) VALUES(6, "Arabic", "Algeria");
INSERT INTO Languages(id, name, country) VALUES(7, "French", "Algeria");
INSERT INTO Languages(id, name, country) VALUES(8, "Chaouia Berber", "Algeria");
INSERT INTO Languages(id, name, country) VALUES(9, "Mzab Berber", "Algeria");
INSERT INTO Languages(id, name, country) VALUES(10, "Tuareg Berber", "Algeria");
INSERT INTO Languages VALUES(11, "Samoan", "American Samoa", 90.6);
INSERT INTO Languages VALUES(12, "English", "American Samoa", 2.9);
INSERT INTO Languages VALUES(13, "Tongan", "American Samoa", 2.4);
INSERT INTO Languages(id, name, country) VALUES(14, "Catalan", "Andorra");
INSERT INTO Languages(id, name, country) VALUES(15, "French", "Andorra");
INSERT INTO Languages(id, name, country) VALUES(16, "Castilian", "Andorra");
INSERT INTO Languages(id, name, country) VALUES(17, "Portuguese", "Andorra");
INSERT INTO Languages(id, name, country) VALUES(18, "Portuguese", "Angola");
INSERT INTO Languages(id, name, country) VALUES(19, "English", "Anguilla");
INSERT INTO Languages(id, name, country) VALUES(20, "English", "Antigua and Barbuda");
INSERT INTO Languages(id, name, country) VALUES(21, "Spanish", "Argentina");
INSERT INTO Languages(id, name, country) VALUES(22, "Italian", "Argentina");
INSERT INTO Languages(id, name, country) VALUES(23, "English", "Argentina");
INSERT INTO Languages(id, name, country) VALUES(24, "German", "Argentina");
INSERT INTO Languages(id, name, country) VALUES(25, "French", "Argentina");
INSERT INTO Languages VALUES(26, "Armenian", "Armenia", 97.9);
INSERT INTO Languages VALUES(27, "Kurdish", "Armenia", 1);
INSERT INTO Languages VALUES(28, "Papiamento", "Aruba", 69.4);
INSERT INTO Languages VALUES(29, "Spanish", "Aruba", 13.7);
INSERT INTO Languages VALUES(30, "English", "Aruba", 7.1);
INSERT INTO Languages VALUES(31, "Dutch", "Aruba", 6.1);
INSERT INTO Languages VALUES(32, "Chinese", "Aruba", 1.5);
INSERT INTO Languages VALUES(33, "English", "Australia", 76.8);
INSERT INTO Languages VALUES(34, "Mandarin", "Australia", 1.6);
INSERT INTO Languages VALUES(35, "Italian", "Australia", 1.4);
INSERT INTO Languages VALUES(36, "Arabic", "Australia", 1.3);
INSERT INTO Languages VALUES(37, "Greek", "Australia", 1.2);
INSERT INTO Languages VALUES(38, "Cantonese", "Australia", 1.2);
INSERT INTO Languages VALUES(39, "Vietnamese", "Australia", 1.1);
INSERT INTO Languages VALUES(40, "German", "Austria", 88.6);
INSERT INTO Languages VALUES(41, "Turkish", "Austria", 2.3);
INSERT INTO Languages VALUES(42, "Serbian", "Austria", 2.2);
INSERT INTO Languages VALUES(43, "Croatian", "Austria", 1.6);
INSERT INTO Languages VALUES(44, "Azerbaijani", "Azerbaijan", 92.5);
INSERT INTO Languages VALUES(45, "Russian", "Azerbaijan", 1.4);
INSERT INTO Languages VALUES(46, "Armenian", "Azerbaijan", 1.4);
INSERT INTO Languages(id, name, country) VALUES(47, "English", "Bahamas, The");
INSERT INTO Languages(id, name, country) VALUES(48, "Creole", "Bahamas, The");
INSERT INTO Languages(id, name, country) VALUES(49, "Arabic", "Bahrain");
INSERT INTO Languages(id, name, country) VALUES(50, "English", "Bahrain");
INSERT INTO Languages(id, name, country) VALUES(51, "Farsi", "Bahrain");
INSERT INTO Languages(id, name, country) VALUES(52, "Urdu", "Bahrain");
INSERT INTO Languages(id, name, country) VALUES(53, "Bangla", "Bangladesh");
INSERT INTO Languages(id, name, country) VALUES(54, "English", "Bangladesh");
INSERT INTO Languages(id, name, country) VALUES(55, "English", "Barbados");
INSERT INTO Languages(id, name, country) VALUES(56, "Bajan", "Barbados");
INSERT INTO Languages VALUES(57, "Belarusian", "Belarus", 23.4);
INSERT INTO Languages VALUES(58, "Russian", "Belarus", 70.2);
INSERT INTO Languages VALUES(59, "Dutch", "Belgium", 60);
INSERT INTO Languages VALUES(60, "French", "Belgium", 40);
INSERT INTO Languages VALUES(61, "Spanish", "Belize", 46);
INSERT INTO Languages VALUES(62, "Creole", "Belize", 32.9);
INSERT INTO Languages VALUES(63, "English", "Belize", 3.9);
INSERT INTO Languages VALUES(64, "Garifuna", "Belize", 3.4);
INSERT INTO Languages VALUES(65, "German", "Belize", 3.3);
INSERT INTO Languages(id, name, country) VALUES(66, "French", "Benin");
INSERT INTO Languages(id, name, country) VALUES(67, "English", "Bermuda");
INSERT INTO Languages(id, name, country) VALUES(68, "Portuguese", "Bermuda");
INSERT INTO Languages VALUES(69, "Sharchhopka", "Bhutan", 28);
INSERT INTO Languages VALUES(70, "Dzongkha", "Bhutan", 24);
INSERT INTO Languages VALUES(71, "Lhotshamkha", "Bhutan", 22);
INSERT INTO Languages VALUES(72, "Spanish", "Bolivia", 60.7);
INSERT INTO Languages VALUES(73, "Quechua", "Bolivia", 21.2);
INSERT INTO Languages VALUES(74, "Aymara", "Bolivia", 14.6);
INSERT INTO Languages(id, name, country) VALUES(75, "Guarani", "Bolivia");
INSERT INTO Languages(id, name, country) VALUES(76, "Bosnian", "Bosnia and Herzegovina");
INSERT INTO Languages(id, name, country) VALUES(77, "Croatian", "Bosnia and Herzegovina");
INSERT INTO Languages(id, name, country) VALUES(78, "Serbian", "Bosnia and Herzegovina");
INSERT INTO Languages VALUES(79, "Setswana", "Botswana", 78.2);
INSERT INTO Languages VALUES(80, "Kalanga", "Botswana", 7.9);
INSERT INTO Languages VALUES(81, "Sekgalagadi", "Botswana", 2.8);
INSERT INTO Languages VALUES(82, "English", "Botswana", 2.1);
INSERT INTO Languages(id, name, country) VALUES(83, "Portuguese", "Brazil");
INSERT INTO Languages(id, name, country) VALUES(84, "English", "British Virgin Islands");
INSERT INTO Languages(id, name, country) VALUES(85, "Malay", "Brunei");
INSERT INTO Languages(id, name, country) VALUES(86, "English", "Brunei");
INSERT INTO Languages(id, name, country) VALUES(87, "Chinese", "Brunei");
INSERT INTO Languages VALUES(88, "Bulgarian", "Bulgaria", 76.8);
INSERT INTO Languages VALUES(89, "Turkish", "Bulgaria", 8.2);
INSERT INTO Languages VALUES(90, "Roma", "Bulgaria", 3.8);
INSERT INTO Languages(id, name, country) VALUES(91, "French", "Burkina Faso");
INSERT INTO Languages(id, name, country) VALUES(92, "Burmese", "Burma");
INSERT INTO Languages VALUES(93, "Kirundi", "Burundi", 29.7);
INSERT INTO Languages(id, name, country) VALUES(94, "Portuguese", "Cabo Verde");
INSERT INTO Languages(id, name, country) VALUES(95, "Crioulo", "Cabo Verde");
INSERT INTO Languages VALUES(96, "Khmer", "Cambodia", 96.3);
INSERT INTO Languages(id, name, country) VALUES(97, "English", "Cameroon");
INSERT INTO Languages(id, name, country) VALUES(98, "French", "Cameroon");
INSERT INTO Languages VALUES(99, "English", "Canada", 58.7);
INSERT INTO Languages VALUES(100, "French", "Canada", 22);
INSERT INTO Languages VALUES(101, "Punjabi", "Canada", 1.4);
INSERT INTO Languages VALUES(102, "Italian", "Canada", 1.3);
INSERT INTO Languages VALUES(103, "Spanish", "Canada", 1.3);
INSERT INTO Languages VALUES(104, "German", "Canada", 1.3);
INSERT INTO Languages VALUES(105, "Cantonese", "Canada", 1.2);
INSERT INTO Languages VALUES(106, "Tagalog", "Canada", 1.2);
INSERT INTO Languages VALUES(107, "Arabic", "Canada", 1.1);
INSERT INTO Languages VALUES(108, "English", "Cayman Islands", 90.9);
INSERT INTO Languages VALUES(109, "Spanish", "Cayman Islands", 4);
INSERT INTO Languages VALUES(110, "Filipino", "Cayman Islands", 3.3);
INSERT INTO Languages(id, name, country) VALUES(111, "French", "Central African Republic");
INSERT INTO Languages(id, name, country) VALUES(112, "Sangho", "Central African Republic");
INSERT INTO Languages(id, name, country) VALUES(113, "French", "Chad");
INSERT INTO Languages(id, name, country) VALUES(114, "Arabic", "Chad");
INSERT INTO Languages(id, name, country) VALUES(115, "Sara", "Chad");
INSERT INTO Languages VALUES(116, "Spanish", "Chile", 99.5);
INSERT INTO Languages VALUES(117, "English", "Chile", 10.2);
INSERT INTO Languages(id, name, country) VALUES(118, "Yue", "China");
INSERT INTO Languages(id, name, country) VALUES(119, "Wu", "China");
INSERT INTO Languages(id, name, country) VALUES(120, "Minbei", "China");
INSERT INTO Languages(id, name, country) VALUES(121, "Minnan", "China");
INSERT INTO Languages(id, name, country) VALUES(122, "Xiang", "China");
INSERT INTO Languages(id, name, country) VALUES(123, "Gan", "China");
INSERT INTO Languages(id, name, country) VALUES(124, "English", "Christmas Island");
INSERT INTO Languages(id, name, country) VALUES(125, "Chinese", "Christmas Island");
INSERT INTO Languages(id, name, country) VALUES(126, "Malay", "Christmas Island");
INSERT INTO Languages(id, name, country) VALUES(127, "Malay", "Cocos Islands");
INSERT INTO Languages(id, name, country) VALUES(128, "English", "Cocos Islands");
INSERT INTO Languages(id, name, country) VALUES(129, "Spanish", "Colombia");
INSERT INTO Languages(id, name, country) VALUES(130, "Arabic", "Comoros");
INSERT INTO Languages(id, name, country) VALUES(131, "French", "Comoros");
INSERT INTO Languages(id, name, country) VALUES(132, "Shikomoro", "Comoros");
INSERT INTO Languages(id, name, country) VALUES(133, "French", "Congo, Democratic Republic of the");
INSERT INTO Languages(id, name, country) VALUES(134, "Lingala", "Congo, Democratic Republic of the");
INSERT INTO Languages(id, name, country) VALUES(135, "Kingwana", "Congo, Democratic Republic of the");
INSERT INTO Languages(id, name, country) VALUES(136, "Kikongo", "Congo, Democratic Republic of the");
INSERT INTO Languages(id, name, country) VALUES(137, "Tshiluba", "Congo, Democratic Republic of the");
INSERT INTO Languages(id, name, country) VALUES(138, "French", "Congo, Republic of the");
INSERT INTO Languages VALUES(139, "English", "Cook Islands", 86.4);
INSERT INTO Languages VALUES(140, "Cook Islands Maori", "Cook Islands", 76.2);
INSERT INTO Languages(id, name, country) VALUES(141, "Spanish", "Costa Rica");
INSERT INTO Languages(id, name, country) VALUES(142, "English", "Costa Rica");
INSERT INTO Languages(id, name, country) VALUES(143, "French", "Cote d'Ivoire");
INSERT INTO Languages VALUES(144, "Croatian", "Croatia", 95.6);
INSERT INTO Languages VALUES(145, "Serbian", "Croatia", 1.2);
INSERT INTO Languages(id, name, country) VALUES(146, "Spanish", "Cuba");
INSERT INTO Languages VALUES(147, "Papiamentu", "Curacao", 81.2);
INSERT INTO Languages VALUES(148, "Dutch", "Curacao", 8);
INSERT INTO Languages VALUES(149, "Spanish", "Curacao", 4);
INSERT INTO Languages VALUES(150, "English", "Curacao", 2.9);
INSERT INTO Languages VALUES(151, "Greek", "Cyprus", 80.9);
INSERT INTO Languages VALUES(152, "Turkish", "Cyprus", 0.2);
INSERT INTO Languages VALUES(153, "English", "Cyprus", 4.1);
INSERT INTO Languages VALUES(154, "Romanian", "Cyprus", 2.9);
INSERT INTO Languages VALUES(155, "Russian", "Cyprus", 2.5);
INSERT INTO Languages VALUES(156, "Bulgarian", "Cyprus", 2.2);
INSERT INTO Languages VALUES(157, "Arabic", "Cyprus", 1.2);
INSERT INTO Languages VALUES(158, "Filippino", "Cyprus", 1.1);
INSERT INTO Languages VALUES(159, "Czech", "Czech Republic", 95.4);
INSERT INTO Languages VALUES(160, "Slovak", "Czech Republic", 1.6);
INSERT INTO Languages(id, name, country) VALUES(161, "Danish", "Denmark");
INSERT INTO Languages(id, name, country) VALUES(162, "Faroese", "Denmark");
INSERT INTO Languages(id, name, country) VALUES(163, "Greenlandic", "Denmark");
INSERT INTO Languages(id, name, country) VALUES(164, "German", "Denmark");
INSERT INTO Languages(id, name, country) VALUES(165, "English", "Dhekelia");
INSERT INTO Languages(id, name, country) VALUES(166, "Greek", "Dhekelia");
INSERT INTO Languages(id, name, country) VALUES(167, "French", "Djibouti");
INSERT INTO Languages(id, name, country) VALUES(168, "Arabic", "Djibouti");
INSERT INTO Languages(id, name, country) VALUES(169, "Somali", "Djibouti");
INSERT INTO Languages(id, name, country) VALUES(170, "Afar", "Djibouti");
INSERT INTO Languages(id, name, country) VALUES(171, "English", "Dominica");
INSERT INTO Languages(id, name, country) VALUES(172, "Spanish", "Dominican Republic");
INSERT INTO Languages VALUES(173, "Spanish", "Ecuador", 93);
INSERT INTO Languages VALUES(174, "Quechua", "Ecuador", 4.1);
INSERT INTO Languages(id, name, country) VALUES(175, "Arabic", "Egypt");
INSERT INTO Languages(id, name, country) VALUES(176, "Spanish", "El Salvador");
INSERT INTO Languages(id, name, country) VALUES(177, "Nahua", "El Salvador");
INSERT INTO Languages VALUES(178, "Spanish", "Equatorial Guinea", 67.6);
INSERT INTO Languages(id, name, country) VALUES(179, "Fang", "Equatorial Guinea");
INSERT INTO Languages VALUES(180, "Bubi)", "Equatorial Guinea", 32.4);
INSERT INTO Languages(id, name, country) VALUES(181, "Tigrinya", "Eritrea");
INSERT INTO Languages(id, name, country) VALUES(182, "Arabic", "Eritrea");
INSERT INTO Languages(id, name, country) VALUES(183, "English", "Eritrea");
INSERT INTO Languages(id, name, country) VALUES(184, "Tigre", "Eritrea");
INSERT INTO Languages(id, name, country) VALUES(185, "Kunama", "Eritrea");
INSERT INTO Languages(id, name, country) VALUES(186, "Afar", "Eritrea");
INSERT INTO Languages VALUES(187, "Estonian", "Estonia", 68.5);
INSERT INTO Languages VALUES(188, "Russian", "Estonia", 29.6);
INSERT INTO Languages VALUES(189, "Ukrainian", "Estonia", 0.6);
INSERT INTO Languages VALUES(190, "Oromo", "Ethiopia", 33.8);
INSERT INTO Languages VALUES(191, "Amharic", "Ethiopia", 29.3);
INSERT INTO Languages VALUES(192, "Somali", "Ethiopia", 6.2);
INSERT INTO Languages VALUES(193, "Tigrigna", "Ethiopia", 5.9);
INSERT INTO Languages VALUES(194, "Sidamo", "Ethiopia", 4);
INSERT INTO Languages VALUES(195, "Wolaytta", "Ethiopia", 2.2);
INSERT INTO Languages VALUES(196, "Gurage", "Ethiopia", 2);
INSERT INTO Languages VALUES(197, "Afar", "Ethiopia", 1.7);
INSERT INTO Languages VALUES(198, "Hadiyya", "Ethiopia", 1.7);
INSERT INTO Languages VALUES(199, "Gamo", "Ethiopia", 1.5);
INSERT INTO Languages VALUES(200, "Gedeo", "Ethiopia", 1.3);
INSERT INTO Languages VALUES(201, "Opuuo", "Ethiopia", 1.2);
INSERT INTO Languages VALUES(202, "Kafa", "Ethiopia", 1.1);
INSERT INTO Languages(id, name, country) VALUES(203, "English", "Ethiopia");
INSERT INTO Languages(id, name, country) VALUES(204, "Arabic", "Ethiopia");
INSERT INTO Languages VALUES(205, "English", "Falkland Islands", 89);
INSERT INTO Languages VALUES(206, "Spanish", "Falkland Islands", 7.7);
INSERT INTO Languages(id, name, country) VALUES(207, "Faroese", "Faroe Islands");
INSERT INTO Languages(id, name, country) VALUES(208, "Danish", "Faroe Islands");
INSERT INTO Languages(id, name, country) VALUES(209, "English", "Fiji");
INSERT INTO Languages(id, name, country) VALUES(210, "Fijian", "Fiji");
INSERT INTO Languages(id, name, country) VALUES(211, "Hindustani", "Fiji");
INSERT INTO Languages VALUES(212, "Finnish", "Finland", 94.2);
INSERT INTO Languages VALUES(213, "Swedish", "Finland", 5.5);
INSERT INTO Languages VALUES(214, "French", "France", 100);
INSERT INTO Languages VALUES(215, "French", "French Polynesia", 61.1);
INSERT INTO Languages VALUES(216, "Polynesian", "French Polynesia", 31.4);
INSERT INTO Languages(id, name, country) VALUES(217, "French", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(218, "Fang", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(219, "Myene", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(220, "Nzebi", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(221, "Bapounou/Eschira", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(222, "Bandjabi", "Gabon");
INSERT INTO Languages(id, name, country) VALUES(223, "English", "Gambia, The");
INSERT INTO Languages(id, name, country) VALUES(224, "Mandinka", "Gambia, The");
INSERT INTO Languages(id, name, country) VALUES(225, "Wolof", "Gambia, The");
INSERT INTO Languages(id, name, country) VALUES(226, "Fula", "Gambia, The");
INSERT INTO Languages(id, name, country) VALUES(227, "Arabic", "Gaza Strip");
INSERT INTO Languages(id, name, country) VALUES(228, "Hebrew", "Gaza Strip");
INSERT INTO Languages(id, name, country) VALUES(229, "English", "Gaza Strip");
INSERT INTO Languages VALUES(230, "Georgian", "Georgia", 71);
INSERT INTO Languages VALUES(231, "Russian", "Georgia", 9);
INSERT INTO Languages VALUES(232, "Armenian", "Georgia", 7);
INSERT INTO Languages VALUES(233, "Azeri", "Georgia", 6);
INSERT INTO Languages(id, name, country) VALUES(234, "German", "Germany");
INSERT INTO Languages VALUES(235, "Asante", "Ghana", 14.8);
INSERT INTO Languages VALUES(236, "Ewe", "Ghana", 12.7);
INSERT INTO Languages VALUES(237, "Fante", "Ghana", 9.9);
INSERT INTO Languages VALUES(238, "Boron", "Ghana", 4.6);
INSERT INTO Languages VALUES(239, "Dagomba", "Ghana", 4.3);
INSERT INTO Languages VALUES(240, "Dangme", "Ghana", 4.3);
INSERT INTO Languages VALUES(241, "Dagarte", "Ghana", 3.7);
INSERT INTO Languages VALUES(242, "Akyem", "Ghana", 3.4);
INSERT INTO Languages VALUES(243, "Ga", "Ghana", 3.4);
INSERT INTO Languages VALUES(244, "Akuapem", "Ghana", 2.9);
INSERT INTO Languages(id, name, country) VALUES(245, "English", "Gibraltar");
INSERT INTO Languages(id, name, country) VALUES(246, "Spanish", "Gibraltar");
INSERT INTO Languages(id, name, country) VALUES(247, "Italian", "Gibraltar");
INSERT INTO Languages(id, name, country) VALUES(248, "Portuguese", "Gibraltar");
INSERT INTO Languages VALUES(249, "Greek", "Greece", 99);
INSERT INTO Languages(id, name, country) VALUES(250, "Greenlandic", "Greenland");
INSERT INTO Languages(id, name, country) VALUES(251, "Danish", "Greenland");
INSERT INTO Languages(id, name, country) VALUES(252, "English", "Greenland");
INSERT INTO Languages(id, name, country) VALUES(253, "English", "Grenada");
INSERT INTO Languages VALUES(254, "English", "Guam", 43.6);
INSERT INTO Languages VALUES(255, "Filipino", "Guam", 21.2);
INSERT INTO Languages VALUES(256, "Chamorro", "Guam", 17.8);
INSERT INTO Languages VALUES(257, "Spanish", "Guatemala", 60);
INSERT INTO Languages(id, name, country) VALUES(258, "English", "Guernsey");
INSERT INTO Languages(id, name, country) VALUES(259, "French", "Guernsey");
INSERT INTO Languages(id, name, country) VALUES(260, "French", "Guinea");
INSERT INTO Languages(id, name, country) VALUES(261, "Portuguese", "Guinea-Bissau");
INSERT INTO Languages(id, name, country) VALUES(262, "Crioulo", "Guinea-Bissau");
INSERT INTO Languages(id, name, country) VALUES(263, "English", "Guyana");
INSERT INTO Languages(id, name, country) VALUES(264, "Creole", "Guyana");
INSERT INTO Languages(id, name, country) VALUES(265, "Caribbean Hindustani", "Guyana");
INSERT INTO Languages(id, name, country) VALUES(266, "Urdu", "Guyana");
INSERT INTO Languages(id, name, country) VALUES(267, "French", "Haiti");
INSERT INTO Languages(id, name, country) VALUES(268, "Creole", "Haiti");
INSERT INTO Languages(id, name, country) VALUES(269, "Italian", "Holy See");
INSERT INTO Languages(id, name, country) VALUES(270, "Latin", "Holy See");
INSERT INTO Languages(id, name, country) VALUES(271, "French", "Holy See");
INSERT INTO Languages(id, name, country) VALUES(272, "Spanish", "Honduras");
INSERT INTO Languages VALUES(273, "Cantonese", "Hong Kong", 89.5);
INSERT INTO Languages VALUES(274, "English", "Hong Kong", 3.5);
INSERT INTO Languages VALUES(275, "Putonghua", "Hong Kong", 1.4);
INSERT INTO Languages VALUES(276, "Hungarian", "Hungary", 99.6);
INSERT INTO Languages VALUES(277, "English", "Hungary", 16);
INSERT INTO Languages VALUES(278, "German", "Hungary", 11.2);
INSERT INTO Languages VALUES(279, "Russian", "Hungary", 1.6);
INSERT INTO Languages VALUES(280, "Romanian", "Hungary", 1.3);
INSERT INTO Languages VALUES(281, "French", "Hungary", 1.2);
INSERT INTO Languages(id, name, country) VALUES(282, "Icelandic", "Iceland");
INSERT INTO Languages(id, name, country) VALUES(283, "English", "Iceland");
INSERT INTO Languages VALUES(284, "Hindi", "India", 41);
INSERT INTO Languages VALUES(285, "Bengali", "India", 8.1);
INSERT INTO Languages VALUES(286, "Telugu", "India", 7.2);
INSERT INTO Languages VALUES(287, "Marathi", "India", 7);
INSERT INTO Languages VALUES(288, "Tamil", "India", 5.9);
INSERT INTO Languages VALUES(289, "Urdu", "India", 5);
INSERT INTO Languages VALUES(290, "Gujarati", "India", 4.5);
INSERT INTO Languages VALUES(291, "Kannada", "India", 3.7);
INSERT INTO Languages VALUES(292, "Malayalam", "India", 3.2);
INSERT INTO Languages VALUES(293, "Oriya", "India", 3.2);
INSERT INTO Languages VALUES(294, "Punjabi", "India", 2.8);
INSERT INTO Languages VALUES(295, "Assamese", "India", 1.3);
INSERT INTO Languages VALUES(296, "Maithili", "India", 1.2);
INSERT INTO Languages(id, name, country) VALUES(297, "Bahasa Indonesia", "Indonesia");
INSERT INTO Languages(id, name, country) VALUES(298, "English", "Indonesia");
INSERT INTO Languages(id, name, country) VALUES(299, "Dutch", "Indonesia");
INSERT INTO Languages VALUES(300, "Persian", "Iran", 53);
INSERT INTO Languages VALUES(301, "Kurdish", "Iran", 10);
INSERT INTO Languages VALUES(302, "Luri", "Iran", 6);
INSERT INTO Languages VALUES(303, "Balochi", "Iran", 2);
INSERT INTO Languages VALUES(304, "Arabic", "Iran", 2);
INSERT INTO Languages(id, name, country) VALUES(305, "Arabic", "Iraq");
INSERT INTO Languages(id, name, country) VALUES(306, "Kurdish", "Iraq");
INSERT INTO Languages(id, name, country) VALUES(307, "Turkmen", "Iraq");
INSERT INTO Languages(id, name, country) VALUES(308, "Assyrian", "Iraq");
INSERT INTO Languages(id, name, country) VALUES(309, "Armenian", "Iraq");
INSERT INTO Languages(id, name, country) VALUES(310, "English", "Ireland");
INSERT INTO Languages(id, name, country) VALUES(311, "Irish", "Ireland");
INSERT INTO Languages(id, name, country) VALUES(312, "English", "Isle of Man");
INSERT INTO Languages(id, name, country) VALUES(313, "Manx Gaelic", "Isle of Man");
INSERT INTO Languages(id, name, country) VALUES(314, "Hebrew", "Israel");
INSERT INTO Languages(id, name, country) VALUES(315, "Arabic", "Israel");
INSERT INTO Languages(id, name, country) VALUES(316, "English", "Israel");
INSERT INTO Languages(id, name, country) VALUES(317, "Italian", "Italy");
INSERT INTO Languages(id, name, country) VALUES(318, "German", "Italy");
INSERT INTO Languages(id, name, country) VALUES(319, "French", "Italy");
INSERT INTO Languages(id, name, country) VALUES(320, "Slovene", "Italy");
INSERT INTO Languages(id, name, country) VALUES(321, "English", "Jamaica");
INSERT INTO Languages(id, name, country) VALUES(322, "Japanese", "Japan");
INSERT INTO Languages VALUES(323, "English", "Jersey", 94.5);
INSERT INTO Languages VALUES(324, "Portuguese", "Jersey", 4.6);
INSERT INTO Languages(id, name, country) VALUES(325, "Arabic", "Jordan");
INSERT INTO Languages(id, name, country) VALUES(326, "English", "Jordan");
INSERT INTO Languages VALUES(327, "Kazakh", "Kazakhstan", 64.4);
INSERT INTO Languages VALUES(328, "Russian", "Kazakhstan", 95);
INSERT INTO Languages(id, name, country) VALUES(329, "English", "Kenya");
INSERT INTO Languages(id, name, country) VALUES(330, "Kiswahili", "Kenya");
INSERT INTO Languages(id, name, country) VALUES(331, "I-Kiribati", "Kiribati");
INSERT INTO Languages(id, name, country) VALUES(332, "English", "Kiribati");
INSERT INTO Languages(id, name, country) VALUES(333, "Korean", "Korea, North");
INSERT INTO Languages(id, name, country) VALUES(334, "Korean", "Korea, South");
INSERT INTO Languages(id, name, country) VALUES(335, "English", "Korea, South");
INSERT INTO Languages(id, name, country) VALUES(336, "Albanian", "Kosovo");
INSERT INTO Languages(id, name, country) VALUES(337, "Serbian", "Kosovo");
INSERT INTO Languages(id, name, country) VALUES(338, "Bosnian", "Kosovo");
INSERT INTO Languages(id, name, country) VALUES(339, "Turkish", "Kosovo");
INSERT INTO Languages(id, name, country) VALUES(340, "Roma", "Kosovo");
INSERT INTO Languages(id, name, country) VALUES(341, "Arabic", "Kuwait");
INSERT INTO Languages VALUES(342, "Kyrgyz", "Kyrgyzstan", 64.7);
INSERT INTO Languages VALUES(343, "Uzbek", "Kyrgyzstan", 13.6);
INSERT INTO Languages VALUES(344, "Russian", "Kyrgyzstan", 12.5);
INSERT INTO Languages VALUES(345, "Dungun", "Kyrgyzstan", 1);
INSERT INTO Languages(id, name, country) VALUES(346, "Lao", "Laos");
INSERT INTO Languages(id, name, country) VALUES(347, "French", "Laos");
INSERT INTO Languages(id, name, country) VALUES(348, "English", "Laos");
INSERT INTO Languages VALUES(349, "Latvian", "Latvia", 56.3);
INSERT INTO Languages VALUES(350, "Russian", "Latvia", 33.8);
INSERT INTO Languages(id, name, country) VALUES(351, "Arabic", "Lebanon");
INSERT INTO Languages(id, name, country) VALUES(352, "French", "Lebanon");
INSERT INTO Languages(id, name, country) VALUES(353, "English", "Lebanon");
INSERT INTO Languages(id, name, country) VALUES(354, "Armenian", "Lebanon");
INSERT INTO Languages(id, name, country) VALUES(355, "Sesotho", "Lesotho");
INSERT INTO Languages(id, name, country) VALUES(356, "English", "Lesotho");
INSERT INTO Languages(id, name, country) VALUES(357, "Zulu", "Lesotho");
INSERT INTO Languages(id, name, country) VALUES(358, "Xhosa", "Lesotho");
INSERT INTO Languages VALUES(359, "English", "Liberia", 20);
INSERT INTO Languages(id, name, country) VALUES(360, "Arabic", "Libya");
INSERT INTO Languages(id, name, country) VALUES(361, "Italian", "Libya");
INSERT INTO Languages(id, name, country) VALUES(362, "English Berber", "Libya");
INSERT INTO Languages VALUES(363, "German", "Liechtenstein", 94.5);
INSERT INTO Languages VALUES(364, "Italian", "Liechtenstein", 1.1);
INSERT INTO Languages VALUES(365, "Lithuanian", "Lithuania", 82);
INSERT INTO Languages VALUES(366, "Russian", "Lithuania", 8);
INSERT INTO Languages VALUES(367, "Polish", "Lithuania", 5.6);
INSERT INTO Languages(id, name, country) VALUES(368, "Luxembourgish", "Luxembourg");
INSERT INTO Languages(id, name, country) VALUES(369, "French", "Luxembourg");
INSERT INTO Languages(id, name, country) VALUES(370, "German", "Luxembourg");
INSERT INTO Languages VALUES(371, "Cantonese", "Macau", 83.3);
INSERT INTO Languages VALUES(372, "Mandarin", "Macau", 5);
INSERT INTO Languages VALUES(373, "Hokkien", "Macau", 3.7);
INSERT INTO Languages VALUES(374, "English", "Macau", 2.3);
INSERT INTO Languages VALUES(375, "Tagalog", "Macau", 1.7);
INSERT INTO Languages VALUES(376, "Portuguese", "Macau", 0.7);
INSERT INTO Languages VALUES(377, "Macedonian", "Macedonia", 66.5);
INSERT INTO Languages VALUES(378, "Albanian", "Macedonia", 25.1);
INSERT INTO Languages VALUES(379, "Turkish", "Macedonia", 3.5);
INSERT INTO Languages VALUES(380, "Roma", "Macedonia", 1.9);
INSERT INTO Languages VALUES(381, "Serbian", "Macedonia", 1.2);
INSERT INTO Languages(id, name, country) VALUES(382, "French", "Madagascar");
INSERT INTO Languages(id, name, country) VALUES(383, "Malagasy", "Madagascar");
INSERT INTO Languages(id, name, country) VALUES(384, "English", "Madagascar");
INSERT INTO Languages(id, name, country) VALUES(385, "English", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(386, "Chichewa", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(387, "Chinyanja", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(388, "Chiyao", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(389, "Chitumbuka", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(390, "Chilomwe", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(391, "Chinkhonde", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(392, "Chingoni", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(393, "Chisena", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(394, "Chitonga", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(395, "Chinyakyusa", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(396, "Chilambya", "Malawi");
INSERT INTO Languages(id, name, country) VALUES(397, "Bahasa Malaysia", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(398, "English", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(399, "Chinese", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(400, "Tamil", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(401, "Telugu", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(402, "Malayalam", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(403, "Panjabi", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(404, "Thai", "Malaysia");
INSERT INTO Languages(id, name, country) VALUES(405, "Dhivehi", "Maldives");
INSERT INTO Languages(id, name, country) VALUES(406, "English", "Maldives");
INSERT INTO Languages(id, name, country) VALUES(407, "French", "Mali");
INSERT INTO Languages VALUES(408, "Bambara", "Mali", 46.3);
INSERT INTO Languages VALUES(409, "Peul/foulfoulbe", "Mali", 9.4);
INSERT INTO Languages VALUES(410, "Dogon", "Mali", 7.2);
INSERT INTO Languages VALUES(411, "Maraka/soninke", "Mali", 6.4);
INSERT INTO Languages VALUES(412, "Malinke", "Mali", 5.6);
INSERT INTO Languages VALUES(413, "Sonrhai/djerma", "Mali", 5.6);
INSERT INTO Languages VALUES(414, "Minianka", "Mali", 4.3);
INSERT INTO Languages VALUES(415, "Tamacheq", "Mali", 3.5);
INSERT INTO Languages VALUES(416, "Senoufo", "Mali", 2.6);
INSERT INTO Languages VALUES(417, "Maltese", "Malta", 90.1);
INSERT INTO Languages VALUES(418, "English", "Malta", 6);
INSERT INTO Languages VALUES(419, "Marshallese", "Marshall Islands", 98.2);
INSERT INTO Languages(id, name, country) VALUES(420, "Arabic", "Mauritania");
INSERT INTO Languages(id, name, country) VALUES(421, "Pulaar", "Mauritania");
INSERT INTO Languages(id, name, country) VALUES(422, "Soninke", "Mauritania");
INSERT INTO Languages(id, name, country) VALUES(423, "Wolof", "Mauritania");
INSERT INTO Languages(id, name, country) VALUES(424, "French", "Mauritania");
INSERT INTO Languages(id, name, country) VALUES(425, "Hassaniya", "Mauritania");
INSERT INTO Languages VALUES(426, "Creole", "Mauritius", 86.5);
INSERT INTO Languages VALUES(427, "Bhojpuri", "Mauritius", 5.3);
INSERT INTO Languages VALUES(428, "French", "Mauritius", 4.1);
INSERT INTO Languages(id, name, country) VALUES(429, "English", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(430, "Chuukese", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(431, "Kosrean", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(432, "Pohnpeian", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(433, "Yapese", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(434, "Ulithian", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(435, "Woleaian", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(436, "Nukuoro", "Micronesia, Federated States of");
INSERT INTO Languages(id, name, country) VALUES(437, "Kapingamarangi", "Micronesia, Federated States of");
INSERT INTO Languages VALUES(438, "Moldovan", "Moldova", 58.8);
INSERT INTO Languages VALUES(439, "Romanian", "Moldova", 16.4);
INSERT INTO Languages VALUES(440, "Russian", "Moldova", 16);
INSERT INTO Languages VALUES(441, "Ukrainian", "Moldova", 3.8);
INSERT INTO Languages VALUES(442, "Gagauz", "Moldova", 3.1);
INSERT INTO Languages VALUES(443, "Bulgarian", "Moldova", 1.1);
INSERT INTO Languages(id, name, country) VALUES(444, "French", "Monaco");
INSERT INTO Languages(id, name, country) VALUES(445, "English", "Monaco");
INSERT INTO Languages(id, name, country) VALUES(446, "Italian", "Monaco");
INSERT INTO Languages(id, name, country) VALUES(447, "Monegasque", "Monaco");
INSERT INTO Languages VALUES(448, "Khalkha Mongol", "Mongolia", 90);
INSERT INTO Languages(id, name, country) VALUES(449, "Turkic", "Mongolia");
INSERT INTO Languages(id, name, country) VALUES(450, "Russian", "Mongolia");
INSERT INTO Languages VALUES(451, "Serbian", "Montenegro", 42.9);
INSERT INTO Languages VALUES(452, "Montenegrin", "Montenegro", 37);
INSERT INTO Languages VALUES(453, "Bosnian", "Montenegro", 5.3);
INSERT INTO Languages VALUES(454, "Albanian", "Montenegro", 5.3);
INSERT INTO Languages VALUES(455, "Serbo-Croat", "Montenegro", 2);
INSERT INTO Languages(id, name, country) VALUES(456, "English", "Montserrat");
INSERT INTO Languages(id, name, country) VALUES(457, "Arabic", "Morocco");
INSERT INTO Languages(id, name, country) VALUES(458, "Tachelhit", "Morocco");
INSERT INTO Languages(id, name, country) VALUES(459, "Tarifit", "Morocco");
INSERT INTO Languages(id, name, country) VALUES(460, "French", "Morocco");
INSERT INTO Languages VALUES(461, "Emakhuwa", "Mozambique", 25.3);
INSERT INTO Languages VALUES(462, "Portuguese", "Mozambique", 10.7);
INSERT INTO Languages VALUES(463, "Xichangana", "Mozambique", 10.3);
INSERT INTO Languages VALUES(464, "Cisena", "Mozambique", 7.5);
INSERT INTO Languages VALUES(465, "Elomwe", "Mozambique", 7);
INSERT INTO Languages VALUES(466, "Echuwabo", "Mozambique", 5.1);
INSERT INTO Languages VALUES(467, "Nama/Damara", "Namibia", 11.3);
INSERT INTO Languages VALUES(468, "Afrikaans", "Namibia", 10.4);
INSERT INTO Languages VALUES(469, "English", "Namibia", 3.4);
INSERT INTO Languages VALUES(470, "Nauruan", "Nauru", 93);
INSERT INTO Languages VALUES(471, "English", "Nauru", 2);
INSERT INTO Languages VALUES(472, "Nepali", "Nepal", 44.6);
INSERT INTO Languages VALUES(473, "Maithali", "Nepal", 11.7);
INSERT INTO Languages VALUES(474, "Bhojpuri", "Nepal", 6);
INSERT INTO Languages VALUES(475, "Tharu", "Nepal", 5.8);
INSERT INTO Languages VALUES(476, "Tamang", "Nepal", 5.1);
INSERT INTO Languages VALUES(477, "Newar", "Nepal", 3.2);
INSERT INTO Languages VALUES(478, "Magar", "Nepal", 3);
INSERT INTO Languages VALUES(479, "Bajjika", "Nepal", 3);
INSERT INTO Languages VALUES(480, "Urdu", "Nepal", 2.6);
INSERT INTO Languages VALUES(481, "Avadhi", "Nepal", 1.9);
INSERT INTO Languages VALUES(482, "Limbu", "Nepal", 1.3);
INSERT INTO Languages VALUES(483, "Gurung", "Nepal", 1.2);
INSERT INTO Languages(id, name, country) VALUES(484, "Dutch", "Netherlands");
INSERT INTO Languages(id, name, country) VALUES(485, "French", "New Caledonia");
INSERT INTO Languages VALUES(486, "English", "New Zealand", 89.8);
INSERT INTO Languages VALUES(487, "Maori", "New Zealand", 3.5);
INSERT INTO Languages VALUES(488, "Samoan", "New Zealand", 2);
INSERT INTO Languages VALUES(489, "Hindi", "New Zealand", 1.6);
INSERT INTO Languages VALUES(490, "French", "New Zealand", 1.2);
INSERT INTO Languages VALUES(491, "Northern Chinese", "New Zealand", 1.2);
INSERT INTO Languages VALUES(492, "Yue", "New Zealand", 1);
INSERT INTO Languages(id, name, country) VALUES(493, "New Zealand Sign Language", "New Zealand");
INSERT INTO Languages VALUES(494, "Spanish", "Nicaragua", 95.3);
INSERT INTO Languages VALUES(495, "Miskito", "Nicaragua", 2.2);
INSERT INTO Languages(id, name, country) VALUES(496, "French", "Niger");
INSERT INTO Languages(id, name, country) VALUES(497, "Hausa", "Niger");
INSERT INTO Languages(id, name, country) VALUES(498, "Djerma", "Niger");
INSERT INTO Languages(id, name, country) VALUES(499, "English", "Nigeria");
INSERT INTO Languages(id, name, country) VALUES(500, "Hausa", "Nigeria");
INSERT INTO Languages(id, name, country) VALUES(501, "Yoruba", "Nigeria");
INSERT INTO Languages(id, name, country) VALUES(502, "Igbo", "Nigeria");
INSERT INTO Languages(id, name, country) VALUES(503, "Fulani", "Nigeria");
INSERT INTO Languages VALUES(504, "Niuean", "Niue", 46);
INSERT INTO Languages VALUES(505, "English", "Niue", 11);
INSERT INTO Languages VALUES(506, "English", "Norfolk Island", 67.6);
INSERT INTO Languages VALUES(507, "Chamorro", "Northern Mariana Islands", 24.1);
INSERT INTO Languages VALUES(508, "English", "Northern Mariana Islands", 17);
INSERT INTO Languages VALUES(509, "Chinese", "Northern Mariana Islands", 6.8);
INSERT INTO Languages(id, name, country) VALUES(510, "Bokmal Norwegian", "Norway");
INSERT INTO Languages(id, name, country) VALUES(511, "Nynorsk Norwegian", "Norway");
INSERT INTO Languages(id, name, country) VALUES(512, "Arabic", "Oman");
INSERT INTO Languages(id, name, country) VALUES(513, "English", "Oman");
INSERT INTO Languages(id, name, country) VALUES(514, "Baluchi", "Oman");
INSERT INTO Languages(id, name, country) VALUES(515, "Urdu", "Oman");
INSERT INTO Languages VALUES(516, "Punjabi", "Pakistan", 48);
INSERT INTO Languages VALUES(517, "Sindhi", "Pakistan", 12);
INSERT INTO Languages VALUES(518, "Saraiki", "Pakistan", 10);
INSERT INTO Languages VALUES(519, "Pashto", "Pakistan", 8);
INSERT INTO Languages VALUES(520, "Urdu", "Pakistan", 8);
INSERT INTO Languages VALUES(521, "Balochi", "Pakistan", 3);
INSERT INTO Languages VALUES(522, "Hindko", "Pakistan", 2);
INSERT INTO Languages VALUES(523, "Brahui", "Pakistan", 1);
INSERT INTO Languages(id, name, country) VALUES(524, "English", "Pakistan");
INSERT INTO Languages(id, name, country) VALUES(525, "Burushaski", "Pakistan");
INSERT INTO Languages VALUES(526, "Palauan", "Palau", 66.6);
INSERT INTO Languages VALUES(527, "Carolinian", "Palau", 0.7);
INSERT INTO Languages VALUES(528, "English", "Palau", 15.5);
INSERT INTO Languages VALUES(529, "Filipino", "Palau", 10.8);
INSERT INTO Languages VALUES(530, "Chinese", "Palau", 1.8);
INSERT INTO Languages(id, name, country) VALUES(531, "Spanish", "Panama");
INSERT INTO Languages VALUES(532, "English", "Panama", 14);
INSERT INTO Languages(id, name, country) VALUES(533, "Tok Pisin", "Papua New Guinea");
INSERT INTO Languages(id, name, country) VALUES(534, "English", "Papua New Guinea");
INSERT INTO Languages(id, name, country) VALUES(535, "Hiri Motu", "Papua New Guinea");
INSERT INTO Languages(id, name, country) VALUES(536, "Spanish", "Paraguay");
INSERT INTO Languages(id, name, country) VALUES(537, "Guarani", "Paraguay");
INSERT INTO Languages VALUES(538, "Spanish", "Peru", 84.1);
INSERT INTO Languages VALUES(539, "Quechua", "Peru", 13);
INSERT INTO Languages VALUES(540, "Aymara", "Peru", 1.7);
INSERT INTO Languages VALUES(541, "Ashaninka", "Peru", 0.3);
INSERT INTO Languages(id, name, country) VALUES(542, "Cebuano", "Philippines");
INSERT INTO Languages(id, name, country) VALUES(543, "Ilocano", "Philippines");
INSERT INTO Languages(id, name, country) VALUES(544, "Bicol", "Philippines");
INSERT INTO Languages(id, name, country) VALUES(545, "Waray", "Philippines");
INSERT INTO Languages(id, name, country) VALUES(546, "Pampango", "Philippines");
INSERT INTO Languages(id, name, country) VALUES(547, "English", "Pitcairn Islands");
INSERT INTO Languages(id, name, country) VALUES(548, "Pitkern", "Pitcairn Islands");
INSERT INTO Languages VALUES(549, "Polish", "Poland", 96.2);
INSERT INTO Languages(id, name, country) VALUES(550, "Portuguese", "Portugal");
INSERT INTO Languages(id, name, country) VALUES(551, "Mirandese", "Portugal");
INSERT INTO Languages(id, name, country) VALUES(552, "Spanish", "Puerto Rico");
INSERT INTO Languages(id, name, country) VALUES(553, "English", "Puerto Rico");
INSERT INTO Languages(id, name, country) VALUES(554, "Arabic", "Qatar");
INSERT INTO Languages VALUES(555, "Romanian", "Romania", 85.4);
INSERT INTO Languages VALUES(556, "Hungarian", "Romania", 6.3);
INSERT INTO Languages VALUES(557, "Romany", "Romania", 1.2);
INSERT INTO Languages VALUES(558, "Russian", "Russia", 96.3);
INSERT INTO Languages VALUES(559, "Dolgang", "Russia", 5.3);
INSERT INTO Languages VALUES(560, "German", "Russia", 1.5);
INSERT INTO Languages VALUES(561, "Chechen", "Russia", 1);
INSERT INTO Languages VALUES(562, "Tatar", "Russia", 3);
INSERT INTO Languages VALUES(563, "Swahili", "Rwanda", 0.02);
INSERT INTO Languages(id, name, country) VALUES(564, "French", "Saint Barthelemy");
INSERT INTO Languages(id, name, country) VALUES(565, "English", "Saint Barthelemy");
INSERT INTO Languages(id, name, country) VALUES(566, "English", "Saint Helena, Ascension, and Tristan da Cunha");
INSERT INTO Languages(id, name, country) VALUES(567, "English", "Saint Kitts and Nevis");
INSERT INTO Languages(id, name, country) VALUES(568, "English", "Saint Lucia");
INSERT INTO Languages(id, name, country) VALUES(569, "French", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(570, "English", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(571, "Dutch", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(572, "French Patois", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(573, "Spanish", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(574, "Papiamento", "Saint Martin");
INSERT INTO Languages(id, name, country) VALUES(575, "French", "Saint Pierre and Miquelon");
INSERT INTO Languages(id, name, country) VALUES(576, "English", "Saint Vincent and the Grenadines");
INSERT INTO Languages(id, name, country) VALUES(577, "Samoan", "Samoa");
INSERT INTO Languages(id, name, country) VALUES(578, "English", "Samoa");
INSERT INTO Languages(id, name, country) VALUES(579, "Italian", "San Marino");
INSERT INTO Languages VALUES(580, "Portuguese", "Sao Tome and Principe", 98.4);
INSERT INTO Languages VALUES(581, "Forro", "Sao Tome and Principe", 36.2);
INSERT INTO Languages VALUES(582, "Cabo Verdian", "Sao Tome and Principe", 8.5);
INSERT INTO Languages VALUES(583, "French", "Sao Tome and Principe", 6.8);
INSERT INTO Languages VALUES(584, "Angolar", "Sao Tome and Principe", 6.6);
INSERT INTO Languages VALUES(585, "English", "Sao Tome and Principe", 4.9);
INSERT INTO Languages VALUES(586, "Lunguie", "Sao Tome and Principe", 1);
INSERT INTO Languages(id, name, country) VALUES(587, "Arabic", "Saudi Arabia");
INSERT INTO Languages(id, name, country) VALUES(588, "French", "Senegal");
INSERT INTO Languages(id, name, country) VALUES(589, "Wolof", "Senegal");
INSERT INTO Languages(id, name, country) VALUES(590, "Pulaar", "Senegal");
INSERT INTO Languages(id, name, country) VALUES(591, "Jola", "Senegal");
INSERT INTO Languages(id, name, country) VALUES(592, "Mandinka", "Senegal");
INSERT INTO Languages VALUES(593, "Serbian", "Serbia", 88.1);
INSERT INTO Languages VALUES(594, "Hungarian", "Serbia", 3.4);
INSERT INTO Languages VALUES(595, "Bosnian", "Serbia", 1.9);
INSERT INTO Languages VALUES(596, "Romany", "Serbia", 1.4);
INSERT INTO Languages VALUES(597, "Seychellois Creole", "Seychelles", 89.1);
INSERT INTO Languages VALUES(598, "English", "Seychelles", 5.1);
INSERT INTO Languages VALUES(599, "French", "Seychelles", 0.7);
INSERT INTO Languages(id, name, country) VALUES(600, "English", "Sierra Leone");
INSERT INTO Languages(id, name, country) VALUES(601, "Mende", "Sierra Leone");
INSERT INTO Languages(id, name, country) VALUES(602, "Temne", "Sierra Leone");
INSERT INTO Languages(id, name, country) VALUES(603, "Krio", "Sierra Leone");
INSERT INTO Languages VALUES(604, "Mandarin", "Singapore", 36.3);
INSERT INTO Languages VALUES(605, "English", "Singapore", 29.8);
INSERT INTO Languages VALUES(606, "Malay", "Singapore", 11.9);
INSERT INTO Languages VALUES(607, "Hokkien", "Singapore", 8.1);
INSERT INTO Languages VALUES(608, "Tamil", "Singapore", 4.4);
INSERT INTO Languages VALUES(609, "Cantonese", "Singapore", 4.1);
INSERT INTO Languages VALUES(610, "Teochew", "Singapore", 3.2);
INSERT INTO Languages VALUES(611, "English", "Sint Maarten", 67.5);
INSERT INTO Languages VALUES(612, "Spanish", "Sint Maarten", 12.9);
INSERT INTO Languages VALUES(613, "Creole", "Sint Maarten", 8.2);
INSERT INTO Languages VALUES(614, "Dutch", "Sint Maarten", 4.2);
INSERT INTO Languages VALUES(615, "Papiamento", "Sint Maarten", 2.2);
INSERT INTO Languages VALUES(616, "French", "Sint Maarten", 1.5);
INSERT INTO Languages VALUES(617, "Slovak", "Slovakia", 78.6);
INSERT INTO Languages VALUES(618, "Hungarian", "Slovakia", 9.4);
INSERT INTO Languages VALUES(619, "Roma", "Slovakia", 2.3);
INSERT INTO Languages VALUES(620, "Ruthenian", "Slovakia", 1);
INSERT INTO Languages VALUES(621, "Slovenian", "Slovenia", 91.1);
INSERT INTO Languages VALUES(622, "Serbo-Croatian", "Slovenia", 4.5);
INSERT INTO Languages(id, name, country) VALUES(623, "Italian", "Slovenia");
INSERT INTO Languages(id, name, country) VALUES(624, "Hungarian", "Slovenia");
INSERT INTO Languages(id, name, country) VALUES(625, "English", "Solomon Islands");
INSERT INTO Languages(id, name, country) VALUES(626, "Somali", "Somalia");
INSERT INTO Languages(id, name, country) VALUES(627, "Arabic", "Somalia");
INSERT INTO Languages(id, name, country) VALUES(628, "Italian", "Somalia");
INSERT INTO Languages(id, name, country) VALUES(629, "English", "Somalia");
INSERT INTO Languages VALUES(630, "IsiZulu", "South Africa", 22.7);
INSERT INTO Languages VALUES(631, "IsiXhosa", "South Africa", 16);
INSERT INTO Languages VALUES(632, "Afrikaans", "South Africa", 13.5);
INSERT INTO Languages VALUES(633, "English", "South Africa", 9.6);
INSERT INTO Languages VALUES(634, "Sepedi", "South Africa", 9.1);
INSERT INTO Languages VALUES(635, "Setswana", "South Africa", 8);
INSERT INTO Languages VALUES(636, "Sesotho", "South Africa", 7.6);
INSERT INTO Languages VALUES(637, "Xitsonga", "South Africa", 4.5);
INSERT INTO Languages VALUES(638, "Tshivenda", "South Africa", 2.4);
INSERT INTO Languages(id, name, country) VALUES(639, "English", "South Sudan");
INSERT INTO Languages(id, name, country) VALUES(640, "Arabic", "South Sudan");
INSERT INTO Languages(id, name, country) VALUES(641, "Nuer", "South Sudan");
INSERT INTO Languages(id, name, country) VALUES(642, "Bari", "South Sudan");
INSERT INTO Languages(id, name, country) VALUES(643, "Zande", "South Sudan");
INSERT INTO Languages(id, name, country) VALUES(644, "Shilluk", "South Sudan");
INSERT INTO Languages VALUES(645, "Castilian Spanish", "Spain", 74);
INSERT INTO Languages VALUES(646, "Catalan", "Spain", 17);
INSERT INTO Languages VALUES(647, "Galician", "Spain", 7);
INSERT INTO Languages VALUES(648, "Sinhala", "Sri Lanka", 74);
INSERT INTO Languages VALUES(649, "Tamil", "Sri Lanka", 18);
INSERT INTO Languages(id, name, country) VALUES(650, "Arabic", "Sudan");
INSERT INTO Languages(id, name, country) VALUES(651, "English", "Sudan");
INSERT INTO Languages(id, name, country) VALUES(652, "Nubian", "Sudan");
INSERT INTO Languages(id, name, country) VALUES(653, "Ta Bedawie", "Sudan");
INSERT INTO Languages(id, name, country) VALUES(654, "Fur", "Sudan");
INSERT INTO Languages(id, name, country) VALUES(655, "Dutch", "Suriname");
INSERT INTO Languages(id, name, country) VALUES(656, "English", "Suriname");
INSERT INTO Languages(id, name, country) VALUES(657, "Sranang Tongo", "Suriname");
INSERT INTO Languages(id, name, country) VALUES(658, "Caribbean Hindustani", "Suriname");
INSERT INTO Languages(id, name, country) VALUES(659, "Javanese", "Suriname");
INSERT INTO Languages(id, name, country) VALUES(660, "Norwegian", "Svalbard");
INSERT INTO Languages(id, name, country) VALUES(661, "Russian", "Svalbard");
INSERT INTO Languages(id, name, country) VALUES(662, "English", "Swaziland");
INSERT INTO Languages(id, name, country) VALUES(663, "Swedish", "Sweden");
INSERT INTO Languages VALUES(664, "German", "Switzerland", 64.9);
INSERT INTO Languages VALUES(665, "French", "Switzerland", 22.6);
INSERT INTO Languages VALUES(666, "Italian", "Switzerland", 8.3);
INSERT INTO Languages VALUES(667, "Serbo-Croatian", "Switzerland", 2.5);
INSERT INTO Languages VALUES(668, "Albanian", "Switzerland", 2.6);
INSERT INTO Languages VALUES(669, "Portuguese", "Switzerland", 3.4);
INSERT INTO Languages VALUES(670, "Spanish", "Switzerland", 2.2);
INSERT INTO Languages VALUES(671, "English", "Switzerland", 4.6);
INSERT INTO Languages VALUES(672, "Romansch", "Switzerland", 0.5);
INSERT INTO Languages(id, name, country) VALUES(673, "Arabic", "Syria");
INSERT INTO Languages(id, name, country) VALUES(674, "Kurdish", "Syria");
INSERT INTO Languages(id, name, country) VALUES(675, "Armenian", "Syria");
INSERT INTO Languages(id, name, country) VALUES(676, "Aramaic", "Syria");
INSERT INTO Languages(id, name, country) VALUES(677, "Circassian French", "Syria");
INSERT INTO Languages(id, name, country) VALUES(678, "English", "Syria");
INSERT INTO Languages(id, name, country) VALUES(679, "Mandarin Chinese", "Taiwan");
INSERT INTO Languages(id, name, country) VALUES(680, "Taiwanese", "Taiwan");
INSERT INTO Languages(id, name, country) VALUES(681, "Tajik", "Tajikistan");
INSERT INTO Languages(id, name, country) VALUES(682, "Kiunguja", "Tanzania");
INSERT INTO Languages(id, name, country) VALUES(683, "English", "Tanzania");
INSERT INTO Languages(id, name, country) VALUES(684, "Arabic", "Tanzania");
INSERT INTO Languages VALUES(685, "Thai", "Thailand", 90.7);
INSERT INTO Languages VALUES(686, "Burmese", "Thailand", 1.3);
INSERT INTO Languages(id, name, country) VALUES(687, "Tetum", "Timor-Leste");
INSERT INTO Languages(id, name, country) VALUES(688, "Portuguese", "Timor-Leste");
INSERT INTO Languages(id, name, country) VALUES(689, "Indonesian", "Timor-Leste");
INSERT INTO Languages(id, name, country) VALUES(690, "English", "Timor-Leste");
INSERT INTO Languages(id, name, country) VALUES(691, "French", "Togo");
INSERT INTO Languages VALUES(692, "Tokelauan", "Tokelau", 93.5);
INSERT INTO Languages VALUES(693, "English", "Tokelau", 58.9);
INSERT INTO Languages VALUES(694, "Samoan", "Tokelau", 45.5);
INSERT INTO Languages VALUES(695, "Tuvaluan", "Tokelau", 11.6);
INSERT INTO Languages VALUES(696, "Kiribati", "Tokelau", 2.7);
INSERT INTO Languages VALUES(697, "Tongan", "Tonga", 10.7);
INSERT INTO Languages VALUES(698, "English", "Tonga", 1.2);
INSERT INTO Languages(id, name, country) VALUES(699, "English", "Trinidad and Tobago");
INSERT INTO Languages(id, name, country) VALUES(700, "Caribbean Hindustani", "Trinidad and Tobago");
INSERT INTO Languages(id, name, country) VALUES(701, "French", "Trinidad and Tobago");
INSERT INTO Languages(id, name, country) VALUES(702, "Spanish", "Trinidad and Tobago");
INSERT INTO Languages(id, name, country) VALUES(703, "Chinese", "Trinidad and Tobago");
INSERT INTO Languages(id, name, country) VALUES(704, "Arabic", "Tunisia");
INSERT INTO Languages(id, name, country) VALUES(705, "French", "Tunisia");
INSERT INTO Languages(id, name, country) VALUES(706, "Berber", "Tunisia");
INSERT INTO Languages(id, name, country) VALUES(707, "Turkish", "Turkey");
INSERT INTO Languages(id, name, country) VALUES(708, "Kurdish", "Turkey");
INSERT INTO Languages VALUES(709, "Turkmen", "Turkmenistan", 72);
INSERT INTO Languages VALUES(710, "Russian", "Turkmenistan", 12);
INSERT INTO Languages VALUES(711, "Uzbek", "Turkmenistan", 9);
INSERT INTO Languages(id, name, country) VALUES(712, "English", "Turks and Caicos Islands");
INSERT INTO Languages(id, name, country) VALUES(713, "Tuvaluan", "Tuvalu");
INSERT INTO Languages(id, name, country) VALUES(714, "English", "Tuvalu");
INSERT INTO Languages(id, name, country) VALUES(715, "Samoan", "Tuvalu");
INSERT INTO Languages(id, name, country) VALUES(716, "Kiribati", "Tuvalu");
INSERT INTO Languages(id, name, country) VALUES(717, "English", "Uganda");
INSERT INTO Languages(id, name, country) VALUES(718, "Swahili", "Uganda");
INSERT INTO Languages(id, name, country) VALUES(719, "Arabic", "Uganda");
INSERT INTO Languages VALUES(720, "Ukrainian", "Ukraine", 67);
INSERT INTO Languages VALUES(721, "Russian", "Ukraine", 24);
INSERT INTO Languages(id, name, country) VALUES(722, "Arabic", "United Arab Emirates");
INSERT INTO Languages(id, name, country) VALUES(723, "Persian", "United Arab Emirates");
INSERT INTO Languages(id, name, country) VALUES(724, "English", "United Arab Emirates");
INSERT INTO Languages(id, name, country) VALUES(725, "Hindi", "United Arab Emirates");
INSERT INTO Languages(id, name, country) VALUES(726, "Urdu", "United Arab Emirates");
INSERT INTO Languages(id, name, country) VALUES(727, "English", "United Kingdom");
INSERT INTO Languages VALUES(728, "English", "United States", 82.1);
INSERT INTO Languages VALUES(729, "Spanish", "United States", 10.7);
INSERT INTO Languages(id, name, country) VALUES(730, "Spanish", "Uruguay");
INSERT INTO Languages(id, name, country) VALUES(731, "Portunol", "Uruguay");
INSERT INTO Languages(id, name, country) VALUES(732, "Brazilero", "Uruguay");
INSERT INTO Languages VALUES(733, "Uzbek", "Uzbekistan", 74.3);
INSERT INTO Languages VALUES(734, "Russian", "Uzbekistan", 14.2);
INSERT INTO Languages VALUES(735, "Tajik", "Uzbekistan", 4.4);
INSERT INTO Languages VALUES(736, "Bislama", "Vanuatu", 33.7);
INSERT INTO Languages VALUES(737, "English", "Vanuatu", 2);
INSERT INTO Languages VALUES(738, "French", "Vanuatu", 0.6);
INSERT INTO Languages(id, name, country) VALUES(739, "Spanish", "Venezuela");
INSERT INTO Languages(id, name, country) VALUES(740, "Vietnamese", "Vietnam");
INSERT INTO Languages(id, name, country) VALUES(741, "English", "Vietnam");
INSERT INTO Languages(id, name, country) VALUES(742, "Chinese", "Vietnam");
INSERT INTO Languages VALUES(743, "English", "Virgin Islands", 74.7);
INSERT INTO Languages VALUES(744, "Wallisian", "Wallis and Futuna", 58.9);
INSERT INTO Languages VALUES(745, "Futunian", "Wallis and Futuna", 30.1);
INSERT INTO Languages VALUES(746, "French", "Wallis and Futuna", 10.8);
INSERT INTO Languages(id, name, country) VALUES(747, "Arabic", "West Bank");
INSERT INTO Languages(id, name, country) VALUES(748, "Hebrew", "West Bank");
INSERT INTO Languages(id, name, country) VALUES(749, "English", "West Bank");
INSERT INTO Languages(id, name, country) VALUES(750, "Standard Arabic", "Western Sahara");
INSERT INTO Languages(id, name, country) VALUES(751, "Hassaniya Arabic", "Western Sahara");
INSERT INTO Languages(id, name, country) VALUES(752, "Moroccan Arabic", "Western Sahara");
INSERT INTO Languages(id, name, country) VALUES(753, "Arabic", "Yemen");
INSERT INTO Languages VALUES(754, "Bembe", "Zambia", 33.4);
INSERT INTO Languages VALUES(755, "Nyanja", "Zambia", 14.7);
INSERT INTO Languages VALUES(756, "Tonga", "Zambia", 11.4);
INSERT INTO Languages VALUES(757, "Lozi", "Zambia", 5.5);
INSERT INTO Languages VALUES(758, "Chewa", "Zambia", 4.5);
INSERT INTO Languages VALUES(759, "Nsenga", "Zambia", 2.9);
INSERT INTO Languages VALUES(760, "Tumbuka", "Zambia", 2.5);
INSERT INTO Languages VALUES(761, "Lunda", "Zambia", 1.9);
INSERT INTO Languages VALUES(762, "Kaonde", "Zambia", 1.8);
INSERT INTO Languages VALUES(763, "Lala", "Zambia", 1.8);
INSERT INTO Languages VALUES(764, "Lamba", "Zambia", 1.8);
INSERT INTO Languages VALUES(765, "English", "Zambia", 1.7);
INSERT INTO Languages VALUES(766, "Luvale", "Zambia", 1.5);
INSERT INTO Languages VALUES(767, "Mambwe", "Zambia", 1.3);
INSERT INTO Languages VALUES(768, "Namwanga", "Zambia", 1.2);
INSERT INTO Languages VALUES(769, "Lenje", "Zambia", 1.1);
INSERT INTO Languages VALUES(770, "Bisa", "Zambia", 1);
INSERT INTO Languages(id, name, country) VALUES(771, "English", "Zimbabwe");
INSERT INTO Languages(id, name, country) VALUES(772, "Shona", "Zimbabwe");
INSERT INTO Languages(id, name, country) VALUES(773, "Sindebele", "Zimbabwe");
