--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bikes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bikes (
    model character(30) NOT NULL,
    trademark character(30) NOT NULL,
    store character varying(30) NOT NULL,
    url character varying(100) NOT NULL,
    kind character varying(30),
    price real NOT NULL
);


ALTER TABLE public.bikes OWNER TO postgres;

--
-- Data for Name: bikes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bikes (model, trademark, store, url, kind, price) FROM stdin;
1.1 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6439.html	ROAD	665.5
1.2 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6440.html	ROAD	819.31
1.5 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6441.html	ROAD	921.85999
2.1 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6442.html	ROAD	1126.9399
2.1 Compact 2011              	Trek                          	Bicimania	http://bicimania.com/trek-compact-2011-p-6040.html	ROAD	959.98999
2.1 Triple 2011               	Trek                          	Bicimania	http://bicimania.com/trek-triple-2011-p-6039.html	ROAD	959.98999
2.3 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6443.html	ROAD	1332.03
2.3 Compact 2011              	Trek                          	Bicimania	http://bicimania.com/trek-compact-2011-p-6038.html	ROAD	1099.99
2.3 Triple 2011               	Trek                          	Bicimania	http://bicimania.com/trek-triple-2011-p-6037.html	ROAD	1099.99
2.5 2012                      	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6444.html	ROAD	1742.1899
2.5 Compact 2011              	Trek                          	Bicimania	http://bicimania.com/trek-compact-2011-p-6036.html	ROAD	1399.99
2.5 Triple 2011               	Trek                          	Bicimania	http://bicimania.com/trek-triple-2011-p-5934.html	ROAD	1439
3500 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-3500-2012-p-6197.html	MTB-FIX	297.48999
3500 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-3500-disc-2012-p-6198.html	MTB-FIX	388.64001
3500 Equipada 2012            	Trek                          	Bicimania	http://bicimania.com/trek-3500-equipada-2012-p-6215.html	MTB-FIX	460.42001
3700 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-3700-2012-p-6216.html	MTB-FIX	322.98999
3700 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-3700-disc-2012-p-6199.html	MTB-FIX	339.98999
3900 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-3900-disc-2012-p-6217.html	MTB-FIX	382.48999
3900 Equipada 2012            	Trek                          	Bicimania	http://bicimania.com/trek-3900-equipada-2012-p-6218.html	MTB-FIX	532.19
4300 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-4300-2012-p-6219.html	MTB-FIX	424.14999
4300 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-4300-disc-2012-p-6220.html	MTB-FIX	467.48999
4500 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-4500-disc-2012-p-6221.html	MTB-FIX	508.98999
4900 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-4900-disc-2012-p-6222.html	MTB-FIX	594.98999
6000 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-6000-disc-2012-p-6203.html	MTB-FIX	679.98999
6300 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-6300-disc-2012-p-6225.html	MTB-FIX	849.98999
6300 Disc WSD 2011            	Trek                          	Bicimania	http://bicimania.com/trek-6300-disc-2011-p-5605.html	MTB-FIX	1024.4
6300 Disc WSD 2012            	Trek                          	Bicimania	http://bicimania.com/trek-6300-disc-2012-p-6226.html	MTB-FIX	849.98999
6500 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-6500-disc-2012-p-6227.html	MTB-FIX	879.98999
6700 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-6700-disc-2012-p-6228.html	MTB-FIX	1039.99
6700 Disc WSD 2012            	Trek                          	Bicimania	http://bicimania.com/trek-6700-disc-2012-p-6230.html	MTB-FIX	1332.03
6900 Disc 2012                	Trek                          	Bicimania	http://bicimania.com/trek-6900-disc-2012-p-6229.html	MTB-FIX	1199.99
7.1 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6559.html	CONFORT	382.48999
7.2 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6560.html	CONFORT	511.69
7.2 FX WSD 2012               	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6561.html	CONFORT	511.69
7.3 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6563.html	CONFORT	614.22998
7.3 FX Disc 2012              	Trek                          	Bicimania	http://bicimania.com/trek-disc-2012-p-6564.html	CONFORT	716.77002
7.3 FX Disc WSD 2012          	Trek                          	Bicimania	http://bicimania.com/trek-disc-2012-p-6565.html	CONFORT	716.77002
7.3 FX WSD 2012               	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6562.html	CONFORT	509.98999
7.5 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6566.html	CONFORT	819.31
7.5 FX Disc 2012              	Trek                          	Bicimania	http://bicimania.com/trek-disc-2012-p-6568.html	CONFORT	921.85999
7.5 FX WSD 2012               	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6567.html	CONFORT	819.31
7.6 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6569.html	CONFORT	1024.4
7.6 FX WSD 2012               	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6570.html	CONFORT	1024.4
7.7 FX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6571.html	CONFORT	1537.11
7100 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-7100-2012-p-6572.html	CONFORT	382.48999
7200 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-7200-2012-p-6573.html	CONFORT	511.69
7300 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-7300-2012-p-6574.html	CONFORT	614.22998
7500 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-7500-2012-p-6575.html	CONFORT	819.31
7700 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-7700-2012-p-6576.html	CONFORT	1024.4
8.2 DS 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6208.html	MTB-FIX	511.69
8.3 DS 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6209.html	MTB-FIX	509.98999
8.4 DS 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6210.html	MTB-FIX	768.03998
8.5 DS 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6211.html	MTB-FIX	921.85999
8000 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-8000-2012-p-6231.html	MTB-FIX	1359.99
8000 WSD 2012                 	Trek                          	Bicimania	http://bicimania.com/trek-8000-2012-p-6232.html	MTB-FIX	1742.1899
8500 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-8500-2012-p-6233.html	MTB-FIX	1599.99
8500 Disc 2011                	Trek                          	Bicimania	http://bicimania.com/trek-8500-disc-2011-p-5513.html	MTB-FIX	1649.99
AFX 2.6 2011                  	Conor                         	Bicimania	http://bicimania.com/conor-2011-p-5802.html	KIDS	312.75
Allez Comp 105 Compact 2012   	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-comp-compact-2012-p-6139.html	ROAD	1189.41
Allez Comp C2 2011            	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-comp-2011-p-5997.html	ROAD	1538.03
Allez Compact 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-compact-2012-p-6136.html	ROAD	717.69
Allez Elite Compact 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-elite-compact-2012-p-6140.html	ROAD	1126.9399
Allez Elite INT Compact 2 2011	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-elite-compact-2011-p-5995.html	ROAD	977.41998
Allez Elite INT X3 2011       	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-elite-2011-p-5996.html	ROAD	1019.92
Allez Sport Compact 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-sport-compact-2012-p-6138.html	ROAD	922.78003
Allez Sport INT Compact 2 2011	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-sport-compact-2011-p-5993.html	ROAD	922.78003
Allez Sport INT X3 2 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-sport-2011-p-5994.html	ROAD	922.78003
Allez Triple 2011             	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-triple-2011-p-5992.html	ROAD	717.78998
Allez Triple 2012             	Specialized                   	Bicimania	http://bicimania.com/specialized-allez-triple-2012-p-6137.html	ROAD	743.42999
Amira Comp Compact 2012       	Specialized                   	Bicimania	http://bicimania.com/specialized-amira-comp-compact-2012-p-6159.html	ROAD	2132.8
Amira Compact 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-amira-compact-2012-p-6158.html	ROAD	1476.53
Amira Elite Compact 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-amira-elite-compact-2012-p-6160.html	ROAD	1804.66
Amira Expert 2011             	Specialized                   	Bicimania	http://bicimania.com/specialized-amira-expert-2011-p-6003.html	ROAD	2719.9199
Big Hit FSR III 2010          	Specialized                   	Bicimania	http://bicimania.com/specialized-2010-p-5272.html	MTB-Double	2160.77
BigHit I 2011                 	Specialized                   	Bicimania	http://bicimania.com/specialized-bighit-2011-p-5733.html	MTB-Double	1614.15
BigHit II 2011                	Specialized                   	Bicimania	http://bicimania.com/specialized-bighit-2011-p-5734.html	MTB-Double	1954.15
BigHit III 2011               	Specialized                   	Bicimania	http://bicimania.com/specialized-bighit-2011-p-5735.html	MTB-Double	2379.1499
Boardwalk D7 2012             	Dahon                         	Bicimania	http://bicimania.com/dahon-boardwalk-2012-p-6602.html	FOLDING	563.97998
Borne 1 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-borne-2012-p-6294.html	CONFORT	1024.4
Borne 2 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-borne-2012-p-6293.html	CONFORT	585.65002
Borne 3 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-borne-2012-p-6292.html	CONFORT	499.98999
Borne 3 GO 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-borne-2012-p-6295.html	CONFORT	511.69
Briza D3 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-briza-2012-p-6621.html	FOLDING	610.13
Briza D7 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-briza-2012-p-6622.html	FOLDING	558.85999
CAAD8 5 105 2012              	Cannondale                    	Bicimania	http://bicimania.com/cannondale-caad8-2012-p-6693.html	ROAD	1230.51
Camber 29 2012                	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-2012-p-6177.html	MTB-Double	1599.58
Camber Comp 2012              	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-comp-2012-p-6174.html	MTB-Double	1599.99
Camber Comp Carbon 29 2012    	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-comp-carbon-2012-p-6178.html	MTB-Double	2625
Camber Elite 2012             	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-elite-2012-p-6175.html	MTB-Double	1999.99
Camber Expert 2011            	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-expert-2011-p-5695.html	MTB-Double	2255.8301
Camber Expert 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-expert-2012-p-6176.html	MTB-Double	1886.7
Camber Expert Carbon 29 2012  	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-expert-carbon-2012-p-6179.html	MTB-Double	3281.27
Camber Pro 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-camber-2012-p-5696.html	MTB-Double	2599.99
Carve Comp 29 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-carve-comp-2012-p-6180.html	MTB-Double	902.28998
Carve Expert 29 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-carve-expert-2012-p-6181.html	MTB-Double	1148.39
Carve Pro 29 2012             	Specialized                   	Bicimania	http://bicimania.com/specialized-carve-2012-p-6182.html	MTB-Double	1640.58
Ciao D5 2012                  	Dahon                         	Bicimania	http://bicimania.com/dahon-ciao-2012-p-6606.html	FOLDING	610.13
Claymore 1 2011               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-claymore-2011-p-5619.html	MTB-Double	3849.3
Claymore 1 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-claymore-2012-p-6384.html	MTB-Double	5638.8101
Claymore 2 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-claymore-2012-p-6385.html	MTB-Double	4100.6699
Cobia 29er 2012               	Trek                          	Bicimania	http://bicimania.com/trek-cobia-29er-2012-p-6204.html	MTB-FIX	848.98999
Cocoa WSD 2012                	Trek                          	Bicimania	http://bicimania.com/trek-cocoa-2012-p-6577.html	CONFORT	467.48999
Concept 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-concept-2012-p-6284.html	MTB-FIX	359.98999
Concept Disc 2012             	Mondraker                     	Bicimania	http://bicimania.com/mondraker-concept-disc-2012-p-6285.html	MTB-FIX	460.42001
Cronus CX Pro 2012            	Trek                          	Bicimania	http://bicimania.com/trek-cronus-2012-p-6437.html	ROAD	2562.53
Cronus CX Ultimate 2012       	Trek                          	Bicimania	http://bicimania.com/trek-cronus-ultimate-2012-p-6438.html	ROAD	3587.96
Crosstrail 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-crosstrail-2012-p-6142.html	ROAD	410.09
Crosstrail Comp Disc 2012     	Specialized                   	Bicimania	http://bicimania.com/specialized-crosstrail-comp-disc-2012-p-6145.html	ROAD	871.51001
Crosstrail Disc 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-crosstrail-disc-2012-p-6143.html	ROAD	451.10001
Crosstrail Sport 2012         	Specialized                   	Bicimania	http://bicimania.com/specialized-crosstrail-sport-2012-p-6144.html	ROAD	584.39001
CruX Comp Apex 2012           	Specialized                   	Bicimania	http://bicimania.com/specialized-crux-comp-apex-2012-p-6146.html	ROAD	1394.49
CruX Expert Force 2012        	Specialized                   	Bicimania	http://bicimania.com/specialized-crux-expert-force-2012-p-6147.html	ROAD	2050.77
Curl 2012                     	Dahon                         	Bicimania	http://bicimania.com/dahon-curl-2012-p-6620.html	FOLDING	1081.8199
Curve D3 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-curve-2012-p-6619.html	FOLDING	562.96002
Cyclocross XO 1 2011          	Trek                          	Bicimania	http://bicimania.com/trek-cyclocross-2011-p-6071.html	ROAD	1639.65
Cyclocross XO 2 2011          	Trek                          	Bicimania	http://bicimania.com/trek-cyclocross-2011-p-6070.html	ROAD	3075.25
Dash P18 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-dash-2012-p-6615.html	FOLDING	835.71997
Demo 8 I 2011                 	Specialized                   	Bicimania	http://bicimania.com/specialized-demo-2011-p-5736.html	MTB-Double	2889.1499
Demo 8 I 2012                 	Specialized                   	Bicimania	http://bicimania.com/specialized-demo-2012-p-6164.html	MTB-Double	2871.1001
Demo 8 II 2010                	Specialized                   	Bicimania	http://bicimania.com/specialized-demo-2010-p-5275.html	MTB-Double	2792.3401
Demo 8 II 2011                	Specialized                   	Bicimania	http://bicimania.com/specialized-demo-2011-p-5737.html	MTB-Double	4249.9199
Demo 8 II 2012                	Specialized                   	Bicimania	http://bicimania.com/specialized-demo-2012-p-6165.html	MTB-Double	4429.75
Dolce Comp Compact 2011       	Specialized                   	Bicimania	http://bicimania.com/specialized-dolce-comp-compact-2011-p-6000.html	ROAD	1359.92
Dolce Elite Triple Int 2011   	Specialized                   	Bicimania	http://bicimania.com/specialized-dolce-elite-triple-2011-p-5999.html	ROAD	1019.92
Dolce Sport Compact 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-dolce-sport-compact-2012-p-6161.html	ROAD	1025.3199
Dolce Triple 2011             	Specialized                   	Bicimania	http://bicimania.com/specialized-dolce-triple-2011-p-5998.html	ROAD	679.91998
Dolce Triple 2012             	Specialized                   	Bicimania	http://bicimania.com/specialized-dolce-triple-2012-p-6162.html	ROAD	656.19
Duel Pro Team 2012            	Mondraker                     	Bicimania	http://bicimania.com/mondraker-duel-team-2012-p-6301.html	BMX	769.07001
Dune 2012                     	Mondraker                     	Bicimania	http://bicimania.com/mondraker-dune-2012-p-6373.html	MTB-Double	2307.2
Dune R 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-dune-2012-p-6374.html	MTB-Double	2152
Dune RR 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-dune-2012-p-6375.html	MTB-Double	3373.6399
Dune RR LTD 2012              	Mondraker                     	Bicimania	http://bicimania.com/mondraker-dune-2012-p-6376.html	MTB-Double	4911.7798
Eco C6 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6595.html	FOLDING	357.87
Eco C7 2012 DISPONIBLE        	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-disponible-p-6594.html	FOLDING	409.14001
Elite 9.9 SSL 2011            	Trek                          	Bicimania	http://bicimania.com/trek-elite-2011-p-5527.html	MTB-FIX	6664.23
Elite XC 9.6 OCLV 2012        	Trek                          	Bicimania	http://bicimania.com/trek-elite-oclv-2012-p-6234.html	MTB-FIX	1359.99
Elite XC 9.7 OCLV 2012        	Trek                          	Bicimania	http://bicimania.com/trek-elite-oclv-2012-p-6235.html	MTB-FIX	1599.99
Elite XC 9.8 OCLV 2012        	Trek                          	Bicimania	http://bicimania.com/trek-elite-oclv-2012-p-6236.html	MTB-FIX	2562.53
Elite XC 9.9 SSL OCLV 2012    	Trek                          	Bicimania	http://bicimania.com/trek-elite-oclv-2012-p-6237.html	MTB-FIX	6664.23
Enduro Comp 2011              	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-comp-2011-p-5726.html	MTB-Double	2871.0801
Enduro Comp 2012              	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-comp-2012-p-6584.html	MTB-Double	2768.54
Enduro EVO 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-2012-p-6166.html	MTB-Double	2050.03
Enduro Expert 2010            	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-expert-2010-p-5232.html	MTB-Double	2840.1399
Enduro Expert 2011            	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-expert-2011-p-5727.html	MTB-Double	3399.9199
Enduro Expert EVO 2012        	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-expert-2012-p-6167.html	MTB-Double	4409.2202
Enduro Pro Carbon 2010        	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-carbon-2010-p-5233.html	MTB-Double	4060.8
Enduro Pro Carbon 2011        	Specialized                   	Bicimania	http://bicimania.com/specialized-enduro-carbon-2011-p-5728.html	MTB-Double	4419.9199
Epic Comp 2012                	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-comp-2012-p-6168.html	MTB-Double	2214.8301
Epic Comp 29 2012             	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-comp-2012-p-6169.html	MTB-Double	2768.54
Epic Comp Carbon 2012         	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-comp-carbon-2012-p-6170.html	MTB-Double	3399.99
Epic Comp Carbon 29 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-comp-carbon-2012-p-6171.html	MTB-Double	3588.8799
Epic Elite 2011               	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-elite-2011-p-5718.html	MTB-Double	3076.1699
Epic Elite 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-elite-2012-p-6592.html	MTB-Double	2972.7
Epic Expert Carbon 2012       	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-expert-carbon-2012-p-6172.html	MTB-Double	4614.2998
Epic Expert Carbon 29 2012    	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-expert-carbon-2012-p-6173.html	MTB-Double	3691.4399
Epic Expert EVO 2011          	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-expert-2011-p-5720.html	MTB-Double	2974.9199
Epic Marathon Carbon 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-epic-marathon-carbon-2011-p-5722.html	MTB-Double	5332.1001
Era Comp 2011                 	Specialized                   	Bicimania	http://bicimania.com/specialized-comp-2011-p-5724.html	MTB-Double	5332.1001
Espresso D21 2012             	Dahon                         	Bicimania	http://bicimania.com/dahon-espresso-2012-p-6627.html	FOLDING	497.32999
Factor 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-factor-2012-p-6367.html	MTB-Double	1799.99
Factor R 2012                 	Mondraker                     	Bicimania	http://bicimania.com/mondraker-factor-2012-p-6368.html	MTB-Double	2717.3701
Factor RR 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-factor-2012-p-6369.html	MTB-Double	3476.1899
Finalist 2012                 	Mondraker                     	Bicimania	http://bicimania.com/mondraker-finalist-2012-p-6311.html	MTB-FIX	679.98999
Finalist 29er 2012            	Mondraker                     	Bicimania	http://bicimania.com/mondraker-finalist-29er-2012-p-6307.html	MTB-FIX	974.15002
Finalist Pro 2012             	Mondraker                     	Bicimania	http://bicimania.com/mondraker-finalist-2012-p-6312.html	MTB-FIX	839.98999
Finalist Pro 29er 2012        	Mondraker                     	Bicimania	http://bicimania.com/mondraker-finalist-29er-2012-p-6308.html	MTB-FIX	919.98999
Fisher 29er Cobia 2011        	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-cobia-2011-p-5597.html	MTB-FIX	1126.9399
Fisher 29er Mamba 2011        	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-mamba-2011-p-5598.html	MTB-FIX	819.31
Fisher 29er Marlin 2011       	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-marlin-2011-p-5599.html	MTB-FIX	614.22998
Fisher 29er Paragon 2011      	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-paragon-2011-p-5595.html	MTB-FIX	1947.28
Fisher 29er Superfly 100 2011 	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-superfly-2011-p-5602.html	MTB-Double	5126.0898
Fisher 29er Superfly 2011     	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-superfly-2011-p-5594.html	MTB-FIX	3587.96
Fisher 29er X-Caliber 2011    	Trek                          	Bicimania	http://bicimania.com/trek-fisher-29er-xcaliber-2011-p-5596.html	MTB-FIX	1537.11
Flash 1 2012                  	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-2012-p-6416.html	MTB-FIX	2254.9099
Flash 29er 1 2012             	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-29er-2012-p-6413.html	MTB-FIX	2254.9099
Flash 29er 2 2012             	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-29er-2012-p-6414.html	MTB-FIX	1947.28
Flash 29er 3 2012             	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-29er-2012-p-6415.html	MTB-FIX	1537.11
Flash 3 2012                  	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-2012-p-6417.html	MTB-FIX	1434.5699
Flash Carbon 1 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-2012-p-6405.html	MTB-FIX	6151.52
Flash Carbon 2 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-2012-p-6406.html	MTB-FIX	4100.6699
Flash Carbon 29er 1 2012      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-29er-2012-p-6410.html	MTB-FIX	4818.4702
Flash Carbon 29er 2 2012      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-29er-2012-p-6411.html	MTB-FIX	3793.04
Flash Carbon 29er 3 2012      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-29er-2012-p-6412.html	MTB-FIX	2767.6201
Flash Carbon 4 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-2012-p-6407.html	MTB-FIX	2357.45
Flash Carbon 4Z 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-2012-p-6408.html	MTB-FIX	2459.99
Flash Carbon Team 2012        	Cannondale                    	Bicimania	http://bicimania.com/cannondale-flash-carbon-team-2012-p-6404.html	MTB-FIX	7689.6499
Foxy 2012                     	Mondraker                     	Bicimania	http://bicimania.com/mondraker-foxy-2012-p-6370.html	MTB-Double	2307.2
Foxy Mid Season 2012          	Mondraker                     	Bicimania	http://bicimania.com/mondraker-foxy-season-2012-p-6535.html	MTB-Double	2040.59
Foxy R 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-foxy-2012-p-6371.html	MTB-Double	1999.99
Foxy RR 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-foxy-2012-p-6372.html	MTB-Double	4296.5298
Fuel EX 5 2011                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5542.html	MTB-Double	1639.65
Fuel EX 5 2012                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2012-p-6241.html	MTB-Double	1198.99
Fuel EX 5 WSD 2011            	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5614.html	MTB-Double	1639.65
Fuel EX 6 2012                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2012-p-6242.html	MTB-Double	1439.99
Fuel EX 7 2011                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5540.html	MTB-Double	2357.45
Fuel EX 7 2012                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2012-p-6243.html	MTB-Double	2254.9099
Fuel EX 8 2012                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2012-p-6244.html	MTB-Double	2665.0801
Fuel EX 8 WSD 2011            	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5613.html	MTB-Double	2870.1599
Fuel EX 9 2011                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5538.html	MTB-Double	3485.4199
Fuel EX 9 2012                	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2012-p-6245.html	MTB-Double	3382.8701
Fuel EX 9.7 OCLV 2012         	Trek                          	Bicimania	http://bicimania.com/trek-fuel-oclv-2012-p-6246.html	MTB-Double	2639.99
Fuel EX 9.8 2011              	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5536.html	MTB-Double	5126.0898
Fuel EX 9.8 OCLV 2012         	Trek                          	Bicimania	http://bicimania.com/trek-fuel-oclv-2012-p-6247.html	MTB-Double	4613.3799
Fuel EX 9.9 2011              	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5535.html	MTB-Double	7176.9399
Fuel EX 9.9 OCLV 2012         	Trek                          	Bicimania	http://bicimania.com/trek-fuel-oclv-2012-p-6248.html	MTB-Double	7176.9399
Funky 160 2011                	Conor                         	Bicimania	http://bicimania.com/conor-funky-2011-p-5801.html	KIDS	143.99001
Glide P7 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-glide-2012-p-6623.html	FOLDING	1024.4
Glide P8 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-glide-2012-p-6624.html	FOLDING	1086.95
Hardrock 2012                 	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-2012-p-6184.html	MTB-FIX	328.04999
Hardrock Disc 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-disc-2012-p-6185.html	MTB-FIX	369.07001
Hardrock Sport 2011           	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-sport-2011-p-5659.html	MTB-FIX	407.92001
Hardrock Sport 2012           	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-sport-2012-p-6186.html	MTB-FIX	393.67999
Hardrock Sport Disc 2011      	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-sport-disc-2011-p-5660.html	MTB-FIX	424.92001
Hardrock Sport Disc 29er 2011 	Specialized                   	Bicimania	http://bicimania.com/specialized-hardrock-sport-disc-29er-2011-p-5662.html	MTB-FIX	509.92001
Ion CX 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6435.html	ROAD	1537.11
Ion CX Pro 2012               	Trek                          	Bicimania	http://bicimania.com/trek-2012-p-6436.html	ROAD	2049.8201
Ios S9 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6625.html	FOLDING	1506.35
Jack D24 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-jack-2012-p-6628.html	FOLDING	573.21002
Jack D7 2012                  	Dahon                         	Bicimania	http://bicimania.com/dahon-jack-2012-p-6626.html	FOLDING	538.34998
Jekyll 3 2012                 	Cannondale                    	Bicimania	http://bicimania.com/cannondale-jekyll-2012-p-6388.html	MTB-Double	3690.5
Jekyll 4 2012                 	Cannondale                    	Bicimania	http://bicimania.com/cannondale-jekyll-2012-p-6389.html	MTB-Double	2562.53
Jekyll Carbon 1 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-jekyll-carbon-2012-p-6386.html	MTB-Double	6151.52
Jekyll Carbon 2 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-jekyll-carbon-2012-p-6387.html	MTB-Double	4613.3799
Jetstream P8 2012             	Dahon                         	Bicimania	http://bicimania.com/dahon-jetstream-2012-p-6598.html	FOLDING	1122.84
Jifo 16 2012                  	Dahon                         	Bicimania	http://bicimania.com/dahon-jifo-2012-p-6618.html	FOLDING	614.22998
Jumper                        	Kokua                         	Bicimania	http://bicimania.com/kokua-jumper-p-2601.html	KIDS	199.99001
Langster Seattle 2009         	Specialized                   	Bicimania	http://bicimania.com/specialized-langster-seattle-2009-p-5555.html	CONFORT	457
Lexa 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-lexa-2012-p-6445.html	ROAD	665.5
Lexa S 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-lexa-2012-p-6446.html	ROAD	819.31
Lexa SL 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-lexa-2012-p-6447.html	ROAD	921.85999
Lexa SLX 2012                 	Trek                          	Bicimania	http://bicimania.com/trek-lexa-2012-p-6448.html	ROAD	1126.9399
Lexi Womens 2 2012            	Cannondale                    	Bicimania	http://bicimania.com/cannondale-lexi-womens-2012-p-6426.html	MTB-Double	2049.8201
Lexi Womens 3 2012            	Cannondale                    	Bicimania	http://bicimania.com/cannondale-lexi-womens-2012-p-6427.html	MTB-Double	1537.11
Lithium R 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-lithium-2012-p-6319.html	MTB-Double	2717.3701
Lithium RR 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-lithium-2012-p-6320.html	MTB-Double	3271.1001
Lithium RR LTD 2012           	Mondraker                     	Bicimania	http://bicimania.com/mondraker-lithium-2012-p-6321.html	MTB-Double	6552.46
Lush 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-lush-2012-p-6249.html	MTB-Double	2049.8201
Lush Carbon 2012              	Trek                          	Bicimania	http://bicimania.com/trek-lush-carbon-2012-p-6250.html	MTB-Double	4613.3799
Lush S 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-lush-2012-p-6251.html	MTB-Double	2254.9099
Lush SL 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-lush-2012-p-6252.html	MTB-Double	2665.0801
Madone 3.1 2011               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-5941.html	ROAD	1845.75
Madone 3.1 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6460.html	ROAD	1742.1899
Madone 3.1 Compact 2011       	Trek                          	Bicimania	http://bicimania.com/trek-madone-compact-2011-p-6062.html	ROAD	1844.74
Madone 3.1 WSD 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6461.html	ROAD	1742.1899
Madone 3.5 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6462.html	ROAD	2049.8201
Madone 4.5 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6463.html	ROAD	1947.28
Madone 4.5 Compact 2011       	Trek                          	Bicimania	http://bicimania.com/trek-madone-compact-2011-p-6061.html	ROAD	2049.8201
Madone 4.5 Triple 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-triple-2011-p-6060.html	ROAD	2049.8201
Madone 4.5 WSD 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6464.html	ROAD	1947.28
Madone 4.7 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6465.html	ROAD	2562.53
Madone 4.7 Compact 2011       	Trek                          	Bicimania	http://bicimania.com/trek-madone-compact-2011-p-6059.html	ROAD	2562.53
Madone 4.7 Triple 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-triple-2011-p-6058.html	ROAD	2562.53
Madone 4.9 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6526.html	ROAD	3075.25
Madone 5.2 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6527.html	ROAD	3382.8701
Madone 5.2 H2 Compact 2011    	Trek                          	Bicimania	http://bicimania.com/trek-madone-compact-2011-p-6057.html	ROAD	3382.8701
Madone 5.2 H2 Triple 2011     	Trek                          	Bicimania	http://bicimania.com/trek-madone-triple-2011-p-6056.html	ROAD	3382.8701
Madone 5.5 H2 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6055.html	ROAD	3793.04
Madone 5.9 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6539.html	ROAD	4100.6699
Madone 5.9 H2 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6054.html	ROAD	4100.6699
Madone 6.2 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6540.html	ROAD	4100.6699
Madone 6.2 H1 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6052.html	ROAD	4408.2998
Madone 6.2 H2 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6053.html	ROAD	4408.2998
Madone 6.2 WSD 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6541.html	ROAD	4100.6699
Madone 6.5 2012               	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6542.html	ROAD	4613.3799
Madone 6.5 H1 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6050.html	ROAD	5126.0898
Madone 6.5 H2 2011            	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6051.html	ROAD	5126.0898
Madone 6.5 WSD 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6543.html	ROAD	4613.3799
Madone 6.7 SSL 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6544.html	ROAD	6151.52
Madone 6.7 SSL H1 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6048.html	ROAD	6664.23
Madone 6.7 SSL H2 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6049.html	ROAD	6664.23
Madone 6.7 SSL WSD 2012       	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6545.html	ROAD	6151.52
Madone 6.9 SSL 2012           	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6546.html	ROAD	8202.3604
Madone 6.9 SSL H1 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6046.html	ROAD	8202.3604
Madone 6.9 SSL H2 2011        	Trek                          	Bicimania	http://bicimania.com/trek-madone-2011-p-6047.html	ROAD	8202.3604
Madone 6.9 SSL WSD 2012       	Trek                          	Bicimania	http://bicimania.com/trek-madone-2012-p-6547.html	ROAD	8202.3604
Mamba 29er 2012               	Trek                          	Bicimania	http://bicimania.com/trek-mamba-29er-2012-p-6205.html	MTB-FIX	819.31
Marlin 29er 2012              	Trek                          	Bicimania	http://bicimania.com/trek-marlin-29er-2012-p-6206.html	MTB-FIX	614.22998
Marlin 29er Single Speed 2012 	Trek                          	Bicimania	http://bicimania.com/trek-marlin-29er-single-speed-2012-p-6269.html	MTB-FIX	562.96002
Marlin 29er WSD 2012          	Trek                          	Bicimania	http://bicimania.com/trek-marlin-29er-2012-p-6270.html	MTB-FIX	614.22998
Micro 140 2011                	Conor                         	Bicimania	http://bicimania.com/conor-micro-2011-p-5800.html	KIDS	157.91
Mika 2012                     	Specialized                   	Bicimania	http://bicimania.com/specialized-mika-2012-p-6630.html	MTB-FIX	430.57999
Mika Disc 2012                	Specialized                   	Bicimania	http://bicimania.com/specialized-mika-disc-2012-p-6631.html	MTB-FIX	461.34
Monster 2011                  	Conor                         	Bicimania	http://bicimania.com/conor-monster-2011-p-5799.html	KIDS	102.53
Mu N360 2012                  	Dahon                         	Bicimania	http://bicimania.com/dahon-n360-2012-p-6608.html	FOLDING	1122.84
Mu P24 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6611.html	FOLDING	861.35999
Mu P8 2012                    	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6609.html	FOLDING	644.98999
Mu Uno 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6607.html	FOLDING	644.98999
Mu XL 2012                    	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6610.html	FOLDING	1184.36
Myka Elite 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-elite-2012-p-6634.html	MTB-FIX	656.19
Myka FSR Comp 2012            	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-comp-2012-p-6635.html	MTB-Double	1230.4301
Myka FSR Elite 2011           	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-elite-2011-p-5698.html	MTB-Double	1845.66
Myka FSR Elite 2012           	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-elite-2012-p-6636.html	MTB-Double	1845.66
Myka Sport 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-sport-2012-p-6632.html	MTB-FIX	512.60999
Myka Sport Disc 2011          	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-sport-disc-2011-p-5667.html	MTB-FIX	574.13
Myka Sport Disc 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-myka-sport-disc-2012-p-6633.html	MTB-FIX	604.90002
Navigator 2.0 Equipped 2011   	Trek                          	Bicimania	http://bicimania.com/trek-navigator-equipped-2011-p-5933.html	CONFORT	512.70001
Neko SL 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-neko-2012-p-6212.html	MTB-FIX	768.03998
P-Grom 2010                   	Specialized                   	Bicimania	http://bicimania.com/specialized-pgrom-2010-p-5276.html	MTB-FIX	650.21997
P1 2011                       	Specialized                   	Bicimania	http://bicimania.com/specialized-2011-p-5750.html	MTB-FIX	560.91998
P2 2010                       	Specialized                   	Bicimania	http://bicimania.com/specialized-2010-p-5264.html	MTB-FIX	812.97998
P2 2011                       	Specialized                   	Bicimania	http://bicimania.com/specialized-2011-p-5751.html	MTB-FIX	764.91998
P2 Cr-Mo 2010                 	Specialized                   	Bicimania	http://bicimania.com/specialized-crmo-2010-p-5277.html	MTB-FIX	650.21997
P20 2011                      	Specialized                   	Bicimania	http://bicimania.com/specialized-2011-p-5752.html	BMX	424.92001
P24 2011                      	Specialized                   	Bicimania	http://bicimania.com/specialized-2011-p-5753.html	BMX	424.92001
P3 2010                       	Specialized                   	Bicimania	http://bicimania.com/specialized-2010-p-5278.html	MTB-FIX	1057.12
Pitch Comp 2010               	Specialized                   	Bicimania	http://bicimania.com/specialized-pitch-comp-2010-p-5235.html	MTB-Double	1382.63
Pitch Comp 2011               	Specialized                   	Bicimania	http://bicimania.com/specialized-pitch-comp-2011-p-5730.html	MTB-Double	1845.66
Pitch Pro 2011                	Specialized                   	Bicimania	http://bicimania.com/specialized-pitch-2011-p-5731.html	MTB-Double	2050.74
Play 1 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-play-2012-p-6304.html	MTB-FIX	973.13
Play 2 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-play-2012-p-6303.html	MTB-FIX	819.31
Play 3 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-play-2012-p-6302.html	MTB-FIX	614.22998
Podium 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-2012-p-6313.html	MTB-FIX	1425.34
Podium 29er 2012              	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-29er-2012-p-6309.html	MTB-FIX	1486.86
Podium Carbon 2012            	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-carbon-2012-p-6315.html	MTB-FIX	1642.5
Podium Carbon Pro 2012        	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-carbon-2012-p-6316.html	MTB-FIX	2860.9299
Podium Carbon Pro SL 2012     	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-carbon-2012-p-6317.html	MTB-FIX	3640.25
Podium Carbon Pro SL LTD 2012 	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-carbon-2012-p-6318.html	MTB-FIX	5629.5801
Podium Pro 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-2012-p-6314.html	MTB-FIX	1732.97
Podium Pro 29er 2012          	Mondraker                     	Bicimania	http://bicimania.com/mondraker-podium-29er-2012-p-6310.html	MTB-FIX	1794.49
Prayer 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-prayer-2012-p-6379.html	MTB-Double	2040.59
Quarter I 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-quarter-2012-p-6306.html	MTB-FIX	973.13
Quarter II 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-quarter-2012-p-6305.html	MTB-FIX	573.21002
RZ One Twenty 1 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-twenty-2012-p-6392.html	MTB-Double	2254.9099
RZ One Twenty 2 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-twenty-2012-p-6393.html	MTB-Double	1947.28
RZ One Twenty 3 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-twenty-2012-p-6394.html	MTB-Double	1742.1899
RZ One Twenty XLR 1 2012      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-twenty-2012-p-6390.html	MTB-Double	3587.96
RZ One Twenty XLR 2 2012      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-twenty-2012-p-6391.html	MTB-Double	2870.1599
Remedy 7 2012                 	Trek                          	Bicimania	http://bicimania.com/trek-remedy-2012-p-6253.html	MTB-Double	2459.99
Remedy 8 2012                 	Trek                          	Bicimania	http://bicimania.com/trek-remedy-2012-p-6254.html	MTB-Double	2158.99
Remedy 9 2012                 	Trek                          	Bicimania	http://bicimania.com/trek-remedy-2012-p-6255.html	MTB-Double	3587.96
Remedy 9.7 OCLV 2012          	Trek                          	Bicimania	http://bicimania.com/trek-remedy-oclv-2012-p-6256.html	MTB-Double	3587.96
Remedy 9.8 OCLV 2012          	Trek                          	Bicimania	http://bicimania.com/trek-remedy-oclv-2012-p-6257.html	MTB-Double	4818.4702
Remedy 9.9 OCLV 2012          	Trek                          	Bicimania	http://bicimania.com/trek-remedy-oclv-2012-p-6258.html	MTB-Double	7689.6499
Rock 180 2011                 	Conor                         	Bicimania	http://bicimania.com/conor-rock-2011-p-5798.html	KIDS	152.99001
Rockhopper 2011               	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-2011-p-5670.html	MTB-FIX	722.41998
Rockhopper 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-2012-p-6187.html	MTB-FIX	574.15997
Rockhopper Comp 2011          	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-comp-2011-p-5671.html	MTB-FIX	934.91998
Rockhopper Comp 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-comp-2012-p-6188.html	MTB-FIX	656.19
Rockhopper Comp 29 2011       	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-comp-2011-p-5672.html	MTB-FIX	1230.41
Rockhopper Expert 2012        	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-expert-2012-p-6189.html	MTB-FIX	697.21002
Rockhopper Pro 2011           	Specialized                   	Bicimania	http://bicimania.com/specialized-rockhopper-2011-p-5673.html	MTB-FIX	1189.92
Roo D3 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6612.html	FOLDING	614.22998
Roo D7 2012                   	Dahon                         	Bicimania	http://bicimania.com/dahon-2012-p-6613.html	FOLDING	487.07999
Roubaix Comp Compact 2012     	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-comp-compact-2012-p-6150.html	ROAD	2973.6299
Roubaix Comp SL2 C2 2011      	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-comp-2011-p-6018.html	ROAD	1954.92
Roubaix Compact 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-compact-2012-p-6148.html	ROAD	1476.53
Roubaix Elite SL2 C2 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-elite-2011-p-6017.html	ROAD	1948.2
Roubaix Expert SL3 C2 2011    	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-expert-2011-p-6019.html	ROAD	2804.9199
Roubaix Pro SL3 DA C2 2011    	Specialized                   	Bicimania	http://bicimania.com/specialized-roubaix-2011-p-6020.html	ROAD	4716.8501
Ruby Elite 2010               	Specialized                   	Bicimania	http://bicimania.com/specialized-ruby-elite-2010-p-5567.html	ROAD	1441.9399
Ruby Elite Compact 2011       	Specialized                   	Bicimania	http://bicimania.com/specialized-ruby-elite-compact-2011-p-6001.html	ROAD	2050.74
Rumblefish Elite 29er 2012    	Trek                          	Bicimania	http://bicimania.com/trek-rumblefish-elite-29er-2012-p-6282.html	MTB-Double	3075.25
Rumblefish Pro 29er 2012      	Trek                          	Bicimania	http://bicimania.com/trek-rumblefish-29er-2012-p-6283.html	MTB-Double	4100.6699
S-Works Enduro Carbon 2010    	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-enduro-carbon-2010-p-5234.html	MTB-Double	5207.46
S-Works Enduro Carbon 2011    	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-enduro-carbon-2011-p-5729.html	MTB-Double	5864.9199
S-Works Enduro Carbon 2012    	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-enduro-carbon-2012-p-6578.html	MTB-Double	6870.2402
S-Works Epic Carbon 2011      	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-epic-carbon-2011-p-5723.html	MTB-Double	7177.8599
S-Works Epic Carbon 2012      	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-epic-carbon-2012-p-6580.html	MTB-Double	6309.1499
S-Works Epic Carbon 29 2012   	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-epic-carbon-2012-p-6581.html	MTB-Double	8100.7402
S-Works Ruby 2008             	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-ruby-2008-p-5591.html	ROAD	3051.1101
S-Works Tarmac SL3 LTD 2011   	Specialized                   	Bicimania	http://bicimania.com/specialized-sworks-tarmac-2011-p-6010.html	ROAD	6459.9199
SX Trail 2012                 	Specialized                   	Bicimania	http://bicimania.com/specialized-trail-2012-p-6585.html	MTB-Double	3691.4199
SX Trail I 2009               	Specialized                   	Bicimania	http://bicimania.com/specialized-trail-2009-p-5556.html	MTB-Double	2189.1001
SX Trail II 2009              	Specialized                   	Bicimania	http://bicimania.com/specialized-trail-2009-p-4447.html	MTB-Double	2653
SX Trail II 2010              	Specialized                   	Bicimania	http://bicimania.com/specialized-trail-2010-p-5269.html	MTB-Double	3247.03
SX Trail II 2011              	Specialized                   	Bicimania	http://bicimania.com/specialized-trail-2011-p-5732.html	MTB-Double	3817.27
Scalpel 2 2012                	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-2012-p-6397.html	MTB-Double	4408.2998
Scalpel 29er 3 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-29er-2012-p-6401.html	MTB-Double	2562.53
Scalpel 29er 4 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-29er-2012-p-6402.html	MTB-Double	2049.8201
Scalpel 29er Carbon 1 2012    	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-29er-carbon-2012-p-6399.html	MTB-Double	6151.52
Scalpel 29er Carbon 2 2012    	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-29er-carbon-2012-p-6400.html	MTB-Double	4100.6699
Scalpel 3 2012                	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-2012-p-6398.html	MTB-Double	3382.8701
Scalpel Team 2012             	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scalpel-team-2012-p-6395.html	MTB-Double	8202.3604
Scarlet 2 2012                	Cannondale                    	Bicimania	http://bicimania.com/cannondale-scarlet-2012-p-6425.html	MTB-Double	3382.8701
Scratch 8 2011                	Trek                          	Bicimania	http://bicimania.com/trek-scratch-2011-p-5550.html	MTB-Double	3895.5801
Scratch 8 Air 2011            	Trek                          	Bicimania	http://bicimania.com/trek-scratch-2011-p-5552.html	MTB-Double	3895.5801
Scratch 9 2011                	Trek                          	Bicimania	http://bicimania.com/trek-scratch-2011-p-5549.html	MTB-Double	5126.0898
Scratch 9 Air 2011            	Trek                          	Bicimania	http://bicimania.com/trek-scratch-2011-p-5551.html	MTB-Double	5126.0898
Secteur Comp C2 2011          	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-comp-2011-p-6016.html	ROAD	1317.42
Secteur Comp Compact 2012     	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-comp-compact-2012-p-6154.html	ROAD	1538.03
Secteur Compact 2012          	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-compact-2012-p-6153.html	ROAD	768.96997
Secteur Elite INT C2 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-elite-2011-p-6015.html	ROAD	1179.13
Secteur Sport INT X3 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-sport-2011-p-6014.html	ROAD	764.91998
Secteur X3 2011               	Specialized                   	Bicimania	http://bicimania.com/specialized-secteur-2011-p-6013.html	ROAD	717.69
Session 8 2011                	Trek                          	Bicimania	http://bicimania.com/trek-session-2011-p-5553.html	MTB-Double	4100.6699
Session 8 2012                	Trek                          	Bicimania	http://bicimania.com/trek-session-2012-p-6266.html	MTB-Double	4100.6699
Session 88 2011               	Trek                          	Bicimania	http://bicimania.com/trek-session-2011-p-5554.html	MTB-Double	6151.52
Session 88 2012               	Trek                          	Bicimania	http://bicimania.com/trek-session-2012-p-6267.html	MTB-Double	5638.8101
Session 9.9 OCLV 2012         	Trek                          	Bicimania	http://bicimania.com/trek-session-oclv-2012-p-6268.html	MTB-Double	8202.3604
Skye 2012                     	Trek                          	Bicimania	http://bicimania.com/trek-skye-2012-p-6200.html	MTB-FIX	297.48999
Skye S 2012                   	Trek                          	Bicimania	http://bicimania.com/trek-skye-2012-p-6201.html	MTB-FIX	388.64001
Skye SL 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-skye-2012-p-6202.html	MTB-FIX	424.98999
Skye SL Disc 2012             	Trek                          	Bicimania	http://bicimania.com/trek-skye-disc-2012-p-6223.html	MTB-FIX	467.48999
Skye SLX Disc 2012            	Trek                          	Bicimania	http://bicimania.com/trek-skye-disc-2012-p-6224.html	MTB-FIX	614.22998
Slash 7 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-slash-2012-p-6259.html	MTB-Double	3587.96
Slash 8 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-slash-2012-p-6260.html	MTB-Double	4613.3799
Slash 9 2012                  	Trek                          	Bicimania	http://bicimania.com/trek-slash-2012-p-6261.html	MTB-Double	5638.8101
Speed Concept 2.5 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6069.html	ROAD	1947.28
Speed Concept 2.5 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6548.html	ROAD	1742.1899
Speed Concept 2.5 WSD 2012    	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6549.html	ROAD	1742.1899
Speed Concept 7.0 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6068.html	ROAD	2562.53
Speed Concept 7.0 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6550.html	ROAD	2562.53
Speed Concept 7.0 WSD 2012    	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6551.html	ROAD	2562.53
Speed Concept 7.2 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6067.html	ROAD	3075.25
Speed Concept 7.2 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6552.html	ROAD	3075.25
Speed Concept 7.5 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6066.html	ROAD	3587.96
Speed Concept 7.5 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6553.html	ROAD	3587.96
Speed Concept 7.8 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6554.html	ROAD	4100.6699
Speed Concept 9.5 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6065.html	ROAD	6151.52
Speed Concept 9.5 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6555.html	ROAD	5638.8101
Speed Concept 9.5 WSD 2012    	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6556.html	ROAD	5638.8101
Speed Concept 9.8 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6064.html	ROAD	7176.9399
Speed Concept 9.8 2012        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6557.html	ROAD	6920.5801
Speed Concept 9.8 WSD 2012    	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2012-p-6558.html	ROAD	6920.5801
Speed Concept 9.9 2011        	Trek                          	Bicimania	http://bicimania.com/trek-speed-concept-2011-p-6063.html	ROAD	9227.79
Speed D7 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-speed-2012-p-6603.html	FOLDING	470.67001
Speed P8 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-speed-2012-p-6604.html	FOLDING	665.5
Speed TR 2012                 	Dahon                         	Bicimania	http://bicimania.com/dahon-speed-2012-p-6605.html	FOLDING	1178.21
Status I 2012                 	Specialized                   	Bicimania	http://bicimania.com/specialized-status-2012-p-6697.html	MTB-Double	2199.99
Stumpjumper Expert Carbon 2012	Specialized                   	Bicimania	http://bicimania.com/specialized-stumpjumper-expert-carbon-2012-p-6192.html	MTB-FIX	3281.25
Stumpjumper FSR Comp 2012     	Specialized                   	Bicimania	http://bicimania.com/specialized-stumpjumper-comp-2012-p-6586.html	MTB-Double	2563.46
Stumpjumper FSR Elite 2012    	Specialized                   	Bicimania	http://bicimania.com/specialized-stumpjumper-elite-2012-p-6588.html	MTB-Double	3486.3401
Summum 2012                   	Mondraker                     	Bicimania	http://bicimania.com/mondraker-summum-2012-p-6382.html	MTB-Double	3988.8999
Summum Pro Team 2012          	Mondraker                     	Bicimania	http://bicimania.com/mondraker-summum-team-2012-p-6383.html	MTB-Double	6552.46
SuperSix HI-MOD Di2 2011      	Cannondale                    	Bicimania	http://bicimania.com/cannondale-supersix-himod-2011-p-6028.html	ROAD	5599.2002
SuperSix HI-MOD SRAM RED 2011 	Cannondale                    	Bicimania	http://bicimania.com/cannondale-supersix-himod-sram-2011-p-6030.html	ROAD	3199.2
SuperSix HI-MOD Team 2011     	Cannondale                    	Bicimania	http://bicimania.com/cannondale-supersix-himod-team-2011-p-6027.html	ROAD	6399.2002
Superfly 100 AL Pro 29er 2012 	Trek                          	Bicimania	http://bicimania.com/trek-superfly-29er-2012-p-6279.html	MTB-Double	3382.8701
Superfly 100 OCLV 29er 2012   	Trek                          	Bicimania	http://bicimania.com/trek-superfly-oclv-29er-2012-p-6277.html	MTB-Double	4100.6699
Superfly AL 29er 2012         	Trek                          	Bicimania	http://bicimania.com/trek-superfly-29er-2012-p-6272.html	MTB-FIX	1537.11
Superfly AL Elite 2013        	Trek                          	Bicimania	http://bicimania.com/trek-superfly-elite-2013-p-6692.html	MTB-FIX	1899
Superfly AL Elite 29er 2012   	Trek                          	Bicimania	http://bicimania.com/trek-superfly-elite-29er-2012-p-6273.html	MTB-FIX	1844.74
Superfly Elite OCLV 29er 2012 	Trek                          	Bicimania	http://bicimania.com/trek-superfly-elite-oclv-29er-2012-p-6275.html	MTB-FIX	3587.96
Superfly OCLV 29er 2012       	Trek                          	Bicimania	http://bicimania.com/trek-superfly-oclv-29er-2012-p-6274.html	MTB-FIX	2562.53
Superfly Pro OCLV 29er 2012   	Trek                          	Bicimania	http://bicimania.com/trek-superfly-oclv-29er-2012-p-6276.html	MTB-FIX	5638.8101
Tarazed 2012                  	Dahon                         	Bicimania	http://bicimania.com/dahon-tarazed-2012-p-6629.html	FOLDING	866.47998
Tarmac Apex Mid-Compact 2012  	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-apex-midcompact-2012-p-6155.html	ROAD	1845.66
Tarmac Comp Compact 105 2011  	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-comp-compact-2011-p-6005.html	ROAD	2307.1001
Tarmac Elite Compact 2011     	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-elite-compact-2011-p-6004.html	ROAD	1948.2
Tarmac Elite Mid-Compact 2012 	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-elite-midcompact-2012-p-6156.html	ROAD	2050.74
Tarmac SL3 Expert Compact 2011	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-expert-compact-2011-p-6007.html	ROAD	3383.8
Tarmac SL3 Pro SRAM 2011      	Specialized                   	Bicimania	http://bicimania.com/specialized-tarmac-sram-2011-p-6008.html	ROAD	3909.9199
Top Fuel 8 2011               	Trek                          	Bicimania	http://bicimania.com/trek-fuel-2011-p-5534.html	MTB-Double	1899
Tracker Mid Season 2012       	Mondraker                     	Bicimania	http://bicimania.com/mondraker-tracker-season-2012-p-6536.html	MTB-Double	999
Tracker R 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-tracker-2012-p-6365.html	MTB-Double	1192
Tracker RR 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-tracker-2012-p-6366.html	MTB-Double	1399.99
Trail SL 1 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-2012-p-6418.html	MTB-FIX	1024.4
Trail SL 2 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-2012-p-6419.html	MTB-FIX	921.85999
Trail SL 29er 2 2012          	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-29er-2012-p-6424.html	MTB-FIX	1024.4
Trail SL 3 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-2012-p-6420.html	MTB-FIX	819.31
Trail SL 4 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-2012-p-6421.html	MTB-FIX	665.5
Trail SL 5 2012               	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-2012-p-6422.html	MTB-FIX	562.96002
Trail SL HS-33 2012           	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-hs33-2012-p-6423.html	MTB-FIX	1332.03
Trail SL Womens 2 2012        	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-womens-2012-p-6428.html	MTB-FIX	1024.4
Trail SL Womens 3 2012        	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-womens-2012-p-6429.html	MTB-FIX	768.03998
Trail SL Womens 5 2011        	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-womens-2011-p-5654.html	MTB-FIX	562.96002
Trail SL Womens 5 2012        	Cannondale                    	Bicimania	http://bicimania.com/cannondale-trail-womens-2012-p-6430.html	MTB-FIX	562.96002
Transition Comp 2011          	Specialized                   	Bicimania	http://bicimania.com/specialized-transition-comp-2011-p-6011.html	ROAD	2460.9099
Transition Pro 2011           	Specialized                   	Bicimania	http://bicimania.com/specialized-transition-2011-p-6012.html	ROAD	3383.8
Vector P8 2012                	Dahon                         	Bicimania	http://bicimania.com/dahon-vector-2012-p-6596.html	FOLDING	819.31
Vector X27H 2012              	Dahon                         	Bicimania	http://bicimania.com/dahon-vector-x27h-2012-p-6597.html	FOLDING	1533.01
Ventura 2012                  	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-2012-p-6286.html	MTB-FIX	562.96002
Ventura GO 2012               	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-2012-p-6296.html	MTB-FIX	562.96002
Ventura Pro 2012              	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-2012-p-6288.html	MTB-FIX	599.98999
Ventura Sport 2012            	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-sport-2012-p-6287.html	MTB-FIX	665.5
Ventura X 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-2012-p-6289.html	MTB-FIX	603.96997
Ventura X-Pro 2012            	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-xpro-2012-p-6291.html	MTB-FIX	778.29999
Ventura X-Sport 2012          	Mondraker                     	Bicimania	http://bicimania.com/mondraker-ventura-xsport-2012-p-6290.html	MTB-FIX	517.48999
Vita Sport 2012               	Specialized                   	Bicimania	http://bicimania.com/specialized-vita-sport-2012-p-6163.html	ROAD	442.89999
Vitesse D3 2012               	Dahon                         	Bicimania	http://bicimania.com/dahon-vitesse-2012-p-6599.html	FOLDING	605
Vitesse D7 2012               	Dahon                         	Bicimania	http://bicimania.com/dahon-vitesse-2012-p-6600.html	FOLDING	511.69
Vitesse D7HG 2012             	Dahon                         	Bicimania	http://bicimania.com/dahon-vitesse-d7hg-2012-p-6601.html	FOLDING	702.41998
WRC 206 SP 2011               	Conor                         	Bicimania	http://bicimania.com/conor-2011-p-5797.html	KIDS	229.99001
Wahoo Disc 29er 2012          	Trek                          	Bicimania	http://bicimania.com/trek-wahoo-disc-29er-2012-p-6207.html	MTB-FIX	511.69
X-Caliber 2012                	Trek                          	Bicimania	http://bicimania.com/trek-xcaliber-2012-p-6271.html	MTB-FIX	1039.99
Zenith-X 2012                 	Mondraker                     	Bicimania	http://bicimania.com/mondraker-zenithx-2012-p-6377.html	MTB-Double	3476.1899
Zenith-XR 2012                	Mondraker                     	Bicimania	http://bicimania.com/mondraker-zenithxr-2012-p-6378.html	MTB-Double	4563.1401
1.2 C H2 2012                 	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/12-c-h2-2012	ROAD	696.26001
1.5 C H2 2012                 	Trek                          	Mammoth	http://www.mammoth.es/producto/carretera/trek/15-c-h2-2012	ROAD	783.41998
220 E 24                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/220-e-24	MTB	319
2.3 C H2 2012                 	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/23-c-h2-2012	ROAD	1132.0699
3500 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/3500-disc	MTB	399
3500                          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/3500	MTB	369
3700 Disc 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/3700-disc-2012	MTB	347.62
3700 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/3700-disc	MTB	439
3900 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/3900-disc	MTB	491.17999
4300 DISC 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4300-disc-2012	MTB	478.5
4300 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4300-disc	MTB	599
4500 DISC 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4500-disc-2012	MTB	522
4500 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4500-disc	MTB	659
4700 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4700-disc	MTB	759
4900 Disc                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/4900-disc	MTB	859
6300 (2012)                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/6300-2012	MTB	870.5
6500 (2012)                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/6500-2012	MTB	957.5
6900 DISC 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/6900-disc-2012	MTB	1306
7.1 FX Lady                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/71-fx-lady	URBAN-CONFORT-FOLDING	499
7.1 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/71-fx	URBAN-CONFORT-FOLDING	499
7.2 FX Disc                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/72-fx-disc	URBAN-CONFORT-FOLDING	599
7.2 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/72-fx	URBAN-CONFORT-FOLDING	559
7.2 FX WSD Lady               	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/72-fx-wsd-lady	URBAN-CONFORT-FOLDING	559
7.3 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/73-fx	URBAN-CONFORT-FOLDING	689
7.3 FX WSD Lady               	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/73-fx-wsd-lady	URBAN-CONFORT-FOLDING	689
7.3 FX WSD                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/73-fx-wsd	URBAN-CONFORT-FOLDING	689
7.4 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/74-fx	URBAN-CONFORT-FOLDING	789
7.5 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/75-fx	URBAN-CONFORT-FOLDING	969
7.5 FX WSD                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/75-fx-wsd-0	URBAN-CONFORT-FOLDING	969
7.6 FX                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/76-fx	URBAN-CONFORT-FOLDING	1099
7.6 FX WSD                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/76-fx-wsd	URBAN-CONFORT-FOLDING	1099
8000 (2012)                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/8000-2012	MTB	1480.9
8.1 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/81-ds	URBAN-CONFORT-FOLDING	489
8.2 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/82-ds	URBAN-CONFORT-FOLDING	539
8.3 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/83-ds	URBAN-CONFORT-FOLDING	659
8.4 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/84-ds	URBAN-CONFORT-FOLDING	799
8500 (2012)                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/8500-2012	MTB	1742.5
8.5 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/85-ds	URBAN-CONFORT-FOLDING	999
8.6 DS                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/86-ds	URBAN-CONFORT-FOLDING	1199
Access WLS                    	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/access-wls	MTB	614.22998
Access WLS Pro                	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/access-wls-pro	MTB	840.84998
Access WLS Race               	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/access-wls-race	MTB	1045.9301
Acid 2012                     	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/acid-2012	MTB	764.79999
Acid 29&quot;                 	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/acid-29	MTB	933.14001
Agree GTC Compact             	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/agree-gtc-compact	ROAD	1639.65
Agree GTC Race                	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/agree-gtc-race	ROAD	2307.2
Agree GTC SL DI2              	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/agree-gtc-sl-di2	ROAD	3280.3301
AIM Disc                      	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/aim-disc	MTB	605
AIR 9 Carbon Comp 2012        	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/air-9-carbon-comp-2012	MTB	3039
AIR 9 Carbon Pro              	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/air-9-carbon-pro	MTB	4921.0098
AIR 9 Carbon Race             	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/air-9-carbon-race	MTB	4613.3799
AIR 9 Pro                     	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/air-9-pro	MTB	2562.53
AIR 9 Race                    	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/air-9-race	MTB	3485.4199
Allez Compact 2012            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/allez-compact-2012	ROAD	610
Allez Comp C2 2011            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/allez-comp-c2-2011	ROAD	1229.48
Alma 29 H30                   	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-29-h30	MTB	1640
Alma 29 H50                   	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-29-h50	MTB	1178
Alma 29 H70                   	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-29-h70	MTB	819
Alma H30                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-h30	MTB	1383
Alma H50                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-h50	MTB	1178
Alma S30                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-s30	MTB	2665
Alma S50                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/alma-s50	MTB	2050
AMS 110 Pro                   	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ams-110-pro	MTB	1681.6899
AMS 110 Race                  	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ams-110-race	MTB	2254.9099
AMS 130                       	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ams-130	MTB	1742.1899
AMS 130 Pro                   	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ams-130-pro	MTB	1721.6899
Analog 29&quot;               	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/analog-29	MTB	716.77002
Analog                        	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/analog	MTB	716.77002
Aqua T105                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/aqua-t105	ROAD	1188
Aqua TSR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/aqua-tsr	ROAD	819
Aqua TTG                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/aqua-ttg	ROAD	1024
Arcade 18&quot;               	WeThePeople                   	Mammoth	http://www.mammoth.es/producto/bicicletas/we-people/arcade-18	BMX	399.85999
Arcade 20&quot;               	WeThePeople                   	Mammoth	http://www.mammoth.es/producto/bicicletas/we-people/arcade-20	BMX	420.37
Astron                        	Radio                         	Mammoth	http://www.mammoth.es/producto/mtb/radio/astron	MTB	512.65997
Attention                     	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/attention	MTB	819.31
Boardwalk D7                  	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/boardwalk-d7	URBAN-CONFORT-FOLDING	563.97998
Boulevard A50                 	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/boulevard-a50	URBAN-CONFORT-FOLDING	409
Boulevard Uni A10             	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/boulevard-uni-a10	URBAN-CONFORT-FOLDING	337
Boulevard UNI F10             	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/boulevard-uni-f10	URBAN-CONFORT-FOLDING	296
Boulevard UNI H50             	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/boulevard-uni-h50	URBAN-CONFORT-FOLDING	409
Cali SL                       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cali-sl	MTB	1299
Cali S                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cali-s	MTB	799
Cali                          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cali	MTB	659
Camber 29                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-29	MTB	1845
Camber Comp 29                	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-comp-29	MTB	2460
Camber Comp Carbon 29         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-comp-carbon-29	MTB	3075
Camber Expert Carbon 29       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-expert-carbon-29	MTB	4499
Camber FSR Comp 26 2012       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-fsr-comp-26-2012	MTB	1394.47
Camber Pro Carbon 29          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/camber-pro-carbon-29	MTB	6750
Carpe H50                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/carpe-h50	URBAN-CONFORT-FOLDING	512
Carve Comp 29&quot; 2012      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-comp-29-2012	MTB	957.75
Carve Comp 29                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-comp-29	MTB	1335
Carve Expert 29&quot; 2012    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-expert-29-2012	MTB	1220.15
Carve Expert                  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-expert	MTB	1535
Carve Pro 29&quot; 2012       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-pro-29-2012	MTB	1394.5699
Carve Pro                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/carve-pro	MTB	1699
Cobia 29&quot; 2012           	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cobia-29-2012	MTB	870.58002
Cobia                         	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cobia	MTB	999
Compair                       	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/compair	MTB	695
CrossRip Elite                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/crossrip-elite	URBAN-CONFORT-FOLDING	1229
CrossRip                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/crossrip	URBAN-CONFORT-FOLDING	999
Crosstrail 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/crosstrail-2012	MTB	435
Crosstrail Disc 2012          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/crosstrail-disc-2012	MTB	478
CruX Comp Disc Apex 2012      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/crux-comp-disc-apex-2012	ROAD	1655
CruX Expert Force 2012        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/crux-expert-force-2012	ROAD	2178
Crysis                        	WeThePeople                   	Mammoth	http://www.mammoth.es/producto/bicicletas/we-people/crysis	BMX	594.69
Cuadro Demo 8                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/cuadro-demo-8	MTB	2790
Cuadro Elite Carbon 9.9       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/cuadro-elite-carbon-99	MTB	1499
Cuadro Mojo HD                	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/cuadro-mojo-hd	MTB	2904
Cuadro Mojo SL                	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/cuadro-mojo-sl	MTB	2601.5
Cuadro S-Works Demo 8 Carbon  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/cuadro-s-works-demo-8-carbon	MTB	3795
Curve D3                      	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/curve-d3	URBAN-CONFORT-FOLDING	562.96002
Daily 2 2012                  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/daily-2-2012	URBAN-CONFORT-FOLDING	391
Daily Deluxe 2 2012           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/daily-deluxe-2-2012	URBAN-CONFORT-FOLDING	435
Darko                         	Radio                         	Mammoth	http://www.mammoth.es/producto/bicicletas/radio/darko	BMX	379.35999
Demo 8 I 2012                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/demo-8-i-2012	MTB	3050
Demo 8 I Carbon               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/demo-8-i-carbon	MTB	4999
Demo 8 II 2012                	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/demo-8-ii-2012	MTB	4700
Demo 8 II                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/demo-8-ii-0	MTB	5750
Demo 8 I                      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/demo-8-i-0	MTB	3799
Domane 6.2 Di2 Project One    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/domane-62-di2-project-one	ROAD	5700.3198
ECO C6                        	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/eco-c6	URBAN-CONFORT-FOLDING	357.87
ECO C7                        	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/eco-c7	URBAN-CONFORT-FOLDING	409.14001
Elite 8.5                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-85	MTB	1099
Elite 8.6                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-86	MTB	1299
Elite 8.7                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-87	MTB	1529
Elite 8.8                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-88	MTB	1729
Elite 8.9                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-89	MTB	2149
Elite Carbon 9.6              	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-carbon-96	MTB	1799
Elite Carbon 9.7              	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-carbon-97	MTB	2149
Elite Carbon 9.8              	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-carbon-98	MTB	2549
Elite Carbon 9.9              	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-carbon-99	MTB	4999
Elite Super HPC Pro           	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/elite-super-hpc-pro	MTB	2819.9199
Elite XC 9.7 E 2012           	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/elite-xc-97-e-2012	MTB	1742.5
EMD 9 Comp                    	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/emd-9-comp	MTB	1615.04
EMD 9 Pro                     	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/emd-9-pro	MTB	2049.8201
EMD 9 Race                    	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/emd-9-race	MTB	2152.3601
Enduro Comp                   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/enduro-comp	MTB	3999
Enduro Evo 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/enduro-evo-2012	MTB	2175
Enduro Expert Carbon          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/enduro-expert-carbon	MTB	5535
Enduro Expert EVO             	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/enduro-expert-evo-0	MTB	4650
Enduro Pro Carbon 2011        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/enduro-pro-carbon-2011	MTB	4264.7402
Epic Comp 2012                	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-comp-2012	MTB	2350
Epic Comp 29                  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-comp-29-0	MTB	2949
Epic Comp Carbon 29           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-comp-carbon-29-0	MTB	3849
Epic Elite 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-elite-2012	MTB	2525
Epic Expert Carbon 2012       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-expert-carbon-2012	MTB	3920
Epic Expert Carbon 29 2012    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-expert-carbon-29-2012	MTB	3920
Epic Expert Carbon 29         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-expert-carbon-29-0	MTB	4899
Epic FSR Comp 26&quot; 2012   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-fsr-comp-26-2012	MTB	2350
Epic Marathon Carbon 29       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/epic-marathon-carbon-29	MTB	6150
Era Comp Carbon 2012          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/era-comp-carbon-2012	MTB	2960
Evol                          	Radio                         	Mammoth	http://www.mammoth.es/producto/bicicletas/radio/evol	BMX	348.59
Expedition 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/expedition-2012	URBAN-CONFORT-FOLDING	339
Expedition Sport 2012         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/expedition-sport-2012	URBAN-CONFORT-FOLDING	374
Fate Comp Carbon 29           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/fate-comp-carbon-29	MTB	2665
Folding A10                   	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/folding-a10	URBAN-CONFORT-FOLDING	409
Folding F10                   	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/folding-f10	URBAN-CONFORT-FOLDING	307
Fuel EX 5 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-5-2012	MTB	1306
Fuel EX 5                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-5	MTB	1649
Fuel EX 6                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-6	MTB	1899
Fuel EX 7 E 2012              	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-7-e-2012	MTB	1803
Fuel EX 7                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-7	MTB	2299
Fuel EX 8                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-8	MTB	2599
Fuel EX 9.7                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-97	MTB	3549
Fuel EX 9.8                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-98	MTB	4599
Fuel EX 9.9                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-99	MTB	7599
Fuel EX 9                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/fuel-ex-9	MTB	3549
Hardrock 26 2012              	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-26-2012	MTB	348.54001
Hardrock 26                   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-26	MTB	389
Hardrock Disc 26 2012         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-disc-26-2012	MTB	392.22
Hardrock Disc 26              	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-disc-26	MTB	449
Hardrock Sport 2011           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-sport-2011	MTB	345
Hardrock Sport 26 2012        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-sport-26-2012	MTB	418.26999
Hardrock Sport Disc 26        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-sport-disc-26-0	MTB	562.96002
Hardrock Sport Disc 29        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hardrock-sport-disc-29	MTB	569
Hotrock 12                    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-12-0	MTB	219
Hotrock 16                    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-16	MTB	239
Hotrock 20                    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-20	MTB	349
Hotrock 24 21-v               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-24-21-v	MTB	369
Hotrock 24                    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-24	MTB	399
Hotrock 24 XC Disc            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotrock-24-xc-disc	MTB	549
Hotwalk                       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/hotwalk	MTB	169
Jet 16                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/jet-16	MTB	219
Jet 20                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/jet-20	MTB	239
JET 9 Pro 2012                	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/jet-9-pro-2012	MTB	3099
JET 9 RDO Pro                 	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/jet-9-rdo-pro	MTB	6766.77
Jett Comp                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/jett-comp-0	MTB	1299
Jett Expert                   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/jett-expert	MTB	1640
Jett                          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/jett	MTB	1025
Justice                       	WeThePeople                   	Mammoth	http://www.mammoth.es/producto/bicicletas/we-people/justice	BMX	461.39001
Kid 160                       	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/kid-160	MTB	256.35999
Kid 160 Girl 2012             	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/kid-160-girl-2012	MTB	205.03
Kid 200                       	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/kid-200	MTB	328.14001
Kid 240                       	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/kid-240	MTB	399.92001
Litening Super HPC Pro        	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/litening-super-hpc-pro	ROAD	2210.8101
Live 2 2012                   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/live-2-2012	URBAN-CONFORT-FOLDING	697
Live 2 Mixta 2012             	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/live-2-mixta-2012	URBAN-CONFORT-FOLDING	697
LTD                           	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ltd	MTB	1024.4
LTD Pro 2012                  	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ltd-pro-2012	MTB	948.46997
LTD Pro 29&quot;              	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ltd-pro-29	MTB	1179.24
LTD Race                      	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/ltd-race	MTB	1281.78
Lush Carbon                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/lush-carbon	MTB	4599
Lush SL                       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/lush-sl	MTB	2749
Lush S                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/lush-s	MTB	2349
Lush                          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/lush	MTB	2049
M3E Negro/Blanco/Turquesa/Rosa	Brompton                      	Mammoth	http://www.mammoth.es/producto/bicicletas/brompton/m3e-negroblancoturquesarosa	URBAN-CONFORT-FOLDING	941.34003
M3L Cuadro Colores            	Brompton                      	Mammoth	http://www.mammoth.es/producto/bicicletas/brompton/m3l-cuadro-colores	URBAN-CONFORT-FOLDING	979.28003
Madone 3.5 C H2 2012          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/madone-35-c-h2-2012	ROAD	1742.1899
Madone 4.5 C H2 2012          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/madone-45-c-h2-2012	ROAD	1655.03
Madone 4.9 C E 2012           	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/madone-49-c-e-2012	ROAD	2613.8101
Madone 5.2 C E H2 2102        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/madone-52-c-e-h2-2102	ROAD	2875.29
Mamba 29&quot; 2012           	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mamba-29-2012	MTB	696
Mamba                         	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mamba	MTB	799
Marlin                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/marlin	MTB	599
Master Orca Dura-Ace          	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/master-orca-dura-ace	ROAD	3280
MCR 9 Pro                     	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/mcr-9-pro	MTB	2306.1799
Mojo SLR Kit SLX Float 32     	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/mojo-slr-kit-slx-float-32	MTB	4254.48
Mojo SLR Kit SLX              	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/mojo-slr-kit-slx	MTB	4091.4399
Mojo SLR Kit XT               	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/mojo-slr-kit-xt	MTB	4850.25
Mojo SLR Kit XTR              	Ibis                          	Mammoth	http://www.mammoth.es/producto/bicicletas/ibis/mojo-slr-kit-xtr	MTB	6860.0801
MT 60 Niña                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mt-60-nina	MTB	289
MT 60                         	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mt-60	MTB	289
Mx 20 Team                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-20-team	MTB	337
Mx 20 Xc                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-20-xc	MTB	276
Mx 24 Dirt                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-24-dirt	MTB	266
Mx 24 Team                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-24-team	MTB	409
Mx 24 Xc                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-24-xc	MTB	286
Myka 2012                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-2012	MTB	365
Myka 26                       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-26	MTB	399.89999
Myka Disc 26                  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-disc-26	MTB	499.89999
Myka Elite Disc 2012          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-elite-disc-2012	MTB	695
Myka Elite Disc 26            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-elite-disc-26	MTB	699.90002
Myka Elite Disc 29            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-elite-disc-29	MTB	699.90002
Myka FSR Comp 2012            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-fsr-comp-2012	MTB	1300
Myka FSR Comp                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-fsr-comp-0	MTB	1535
Myka FSR Elite                	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-fsr-elite-0	MTB	2050
Myka Sport 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-sport-2012	MTB	435
Myka Sport Disc 26            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-sport-disc-26	MTB	589.90002
Myka Sport Disc 29            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-sport-disc-29	MTB	599.90002
Myka Step Through             	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/myka-step-through	MTB	399.89999
Mynx SL                       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mynx-sl	MTB	1529
Mynx S                        	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mynx-s	MTB	1079
Mynx                          	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mynx	MTB	659
Mystic 16 2012                	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mystic-16-2012	MTB	189
Mystic 16                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/mystic-16	MTB	219
Neko SL WSD                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/neko-sl-wsd	URBAN-CONFORT-FOLDING	799
Neko S WSD                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/neko-s-wsd	URBAN-CONFORT-FOLDING	659
Neko WSD                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/neko-wsd	URBAN-CONFORT-FOLDING	539
Occam H10                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/occam-h10	MTB	3383
Occam H30                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/occam-h30	MTB	2050
Occam S30                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/occam-s30	MTB	4511
Occam S50                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/occam-s50	MTB	3075
O Nine 3000 2011              	Mérida                        	Mammoth	http://www.mammoth.es/producto/bicicletas/merida/o-nine-3000-2011	MTB	2654.8201
Orca B105                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-b105	ROAD	1947
Orca BLi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-bli2	ROAD	3588
Orca BTH                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-bth	ROAD	2563
Orca GDi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-gdi2	ROAD	9125
Orca GDR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-gdr	ROAD	7485
Orca GFR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-gfr	ROAD	4613
Orca GLi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-gli2	ROAD	5331
Orca GLT                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-glt	ROAD	4408
Orca GRC                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-grc	ROAD	7485
Orca GRD                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-grd	ROAD	6562
Orca GTH                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-gth	ROAD	4408
Orca SDi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-sdi2	ROAD	7382
Orca SDR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-sdr	ROAD	5740
Orca SFR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-sfr	ROAD	3691
Orca SLi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-sli2	ROAD	4100
Orca SLT                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-slt	ROAD	3075
Orca SRC                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-src	ROAD	5434
Orca SRD                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-srd	ROAD	4818
Orca STH                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/orca-sth	ROAD	3383
Ordu GDi2                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/ordu-gdi2	ROAD	10253
Ordu GDR                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/ordu-gdr	ROAD	7177
Ordu GLT                      	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/ordu-glt	ROAD	4100
P.2 2012                      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/p2-2012	MTB	780
Rallon 10                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-10	MTB	5639
Rallon 30                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-30	MTB	3588
Rallon 50                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-50	MTB	2665
Rallon 70                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-70	MTB	2050
Rallon X10                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-x10	MTB	5229
Rallon X30                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/rallon-x30	MTB	3075
Ravel 26 A10                  	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/ravel-26-a10	MTB	358
Ravel 26 DAMA A10             	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/ravel-26-dama-a10	URBAN-CONFORT-FOLDING	358
Reaction GTC pro 29&quot;     	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/reaction-gtc-pro-29	MTB	1742.1899
Reaction Pro                  	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/reaction-pro	MTB	1742.1899
Reason                        	WeThePeople                   	Mammoth	http://www.mammoth.es/producto/bicicletas/we-people/reason	BMX	533.16998
Remedy 7                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/remedy-7	MTB	2499
Remedy 8                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/remedy-8	MTB	2899
Remedy 9.8                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/remedy-98	MTB	4699
Remedy 9.9                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/remedy-99	MTB	7599
Remedy 9                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/remedy-9	MTB	3799
RIP 9 Pro                     	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/rip-9-pro	MTB	4100.6699
Rockhopper 26                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-26	MTB	715
Rockhopper 29                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-29	MTB	715
Rockhopper Comp 26            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-comp-26	MTB	899
Rockhopper Comp 29            	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-comp-29	MTB	899
Rockhopper Expert 2012        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-expert-2012	MTB	740
Rockhopper Pro 2012           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-pro-2012	MTB	1000
Rockhopper Pro 29             	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/rockhopper-pro-29	MTB	1125
Roubaix Compact 2012          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/roubaix-compact-2012	ROAD	1480
Rumblefish AL Elite           	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/rumblefish-al-elite	MTB	2999
Rumblefish AL Pro             	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/rumblefish-al-pro	MTB	3999
Safire Comp 2012              	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/safire-comp-2012	MTB	2175
Secteur Compact 2012          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/secteur-compact-2012	ROAD	653
Secteur Sport Compact 2012    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/secteur-sport-compact-2012	ROAD	784
Session 88                    	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/session-88	MTB	4999
Session 8                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/session-8	MTB	3999
Session 9.9 Cuadro            	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/session-99-cuadro	MTB	4599
Session 9.9                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/session-99	MTB	7999
Sherpa                        	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/sherpa	MTB	614
Shift 2                       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/shift-2	URBAN-CONFORT-FOLDING	439
SIR 9 Pro                     	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/sir-9-pro	MTB	2254.9099
Skye Lady                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/skye-lady	MTB	369
Skye SL 2012                  	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/skye-sl-2012	MTB	434
Skye S Lady                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/skye-s-lady	MTB	399
Skye SL Disc 2012             	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/skye-sl-disc-2012	MTB	477.85001
Skye SL                       	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/skye-sl	MTB	599
Speed P8                      	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/speed-p8	URBAN-CONFORT-FOLDING	665.5
Spicy 516                     	Mtb                           	Mammoth	http://www.mammoth.es/producto/mtb/spicy-516	MTB	3649.8201
Sport Dama H10                	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/sport-dama-h10	MTB	1385
Sport H10                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/sport-h10	MTB	1385
Status I 2012                 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/status-i-2012	MTB	1915
Status II 2012                	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/status-ii-2012	MTB	2525
Status II                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/status-ii-0	MTB	2999
Status I                      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/status-i-0	MTB	2375
Stereo Pro                    	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/stereo-pro	MTB	1803.72
Stereo Race                   	CubeBikes                     	Mammoth	http://www.mammoth.es/producto/bicicletas/cube-bikes/stereo-race	MTB	2819.9199
Strida LT + Kit Premium       	Strida                        	Mammoth	http://www.mammoth.es/producto/bicicletas/strida/strida-lt-kit-premium	URBAN-CONFORT-FOLDING	610.13
Strida Mas + Kit Premium      	Strida                        	Mammoth	http://www.mammoth.es/producto/bicicletas/strida/strida-mas-kit-premium	URBAN-CONFORT-FOLDING	948.52002
Strida SX + Kit Premium       	Strida                        	Mammoth	http://www.mammoth.es/producto/bicicletas/strida/strida-sx-kit-premium	URBAN-CONFORT-FOLDING	712.66998
Stumpjumper Comp 2012         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-comp-2012	MTB	1520
Stumpjumper Comp 29 2012      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-comp-29-2012	MTB	1570
Stumpjumper Comp 29           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-comp-29-0	MTB	1950
Stumpjumper Comp Carbon 2012  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-comp-carbon-2012	MTB	1915
Stumpjumper Comp Carbon 29    	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-comp-carbon-29-0	MTB	2650
Stumpjumper Expert Carbon 29  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-expert-carbon-29-0	MTB	3699
Stumpjumper FSR Comp 2012     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-2012	MTB	2175
Stumpjumper FSR Comp 29 2012  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-29-2012	MTB	2265
Stumpjumper FSR Comp 29       	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-29-0	MTB	2750
Stumpjumper FSR Comp Carbon 29	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-carbon-29	MTB	3485
Stumpjumper FSR Comp EVO 29   	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-evo-29	MTB	2850
Stumpjumper FSR Comp EVO      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-evo	MTB	2850
Stumpjumper FSR Comp          	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-comp-0	MTB	2599
Stumpjumper FSR Elite 29      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-elite-29	MTB	3799
Stumpjumper FSR Elite         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-fsr-elite-0	MTB	3599
Stumpjumper Marathon Carbon 29	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/stumpjumper-marathon-carbon-29	MTB	4599
Superfly AL Elite             	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly-al-elite	MTB	1899
Superfly AL                   	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly-al	MTB	1599
Superfly Comp                 	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly-comp	MTB	2999
Superfly Elite SL             	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly-elite-sl	MTB	4999
Superfly Pro SL               	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly-pro-sl	MTB	7499
Superfly                      	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/superfly	MTB	2399
S-Works Amira SL4 Compact     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/s-works-amira-sl4-compact	MUJER	7690
S-Works Enduro 2011           	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/s-works-enduro-2011	MTB	5306.4702
S-Works Enduro Carbon         	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/s-works-enduro-carbon-0	MTB	7895
S-Works Epic Carbon 2012      	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/s-works-epic-carbon-2012	MTB	6700
Tarmac Comp Mid-Compact 2012  	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/tarmac-comp-mid-compact-2012	ROAD	2090
Terra T105                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/terra-t105	ROAD	2150
Terra TLT                     	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/terra-tlt	ROAD	2973
Trailgator                    	Trailgator                    	Mammoth	http://www.mammoth.es/producto/bicicletas/trailgator/trailgator	MTB	71.650002
Transition Pro                	Specialized                   	Mammoth	http://www.mammoth.es/producto/cuadros/specialized/transition-pro	CUADROS	2041.52
Tuareg                        	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/tuareg	MTB	307
Valac                         	Radio                         	Mammoth	http://www.mammoth.es/producto/bicicletas/radio/valac	BMX	420.37
Venge Expert Mid-Compact 2012 	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/venge-expert-mid-compact-2012	ROAD	3135
Vita Sport 2012               	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/vita-sport-2012	MUJER	470
Vitesse D7                    	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/vitesse-d7	URBAN-CONFORT-FOLDING	511.69
Vitesse D7 HG                 	Dahon                         	Mammoth	http://www.mammoth.es/producto/bicicletas/dahon/vitesse-d7-hg	URBAN-CONFORT-FOLDING	702.41998
Wahoo                         	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/wahoo	MTB	529
WFO 9 Race                    	Niner                         	Mammoth	http://www.mammoth.es/producto/bicicletas/niner/wfo-9-race	MTB	5126.0898
Work 2012                     	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/work-2012	URBAN-CONFORT-FOLDING	348
Work Step-Through 2012        	Specialized                   	Mammoth	http://www.mammoth.es/producto/bicicletas/specialized/work-step-through-2012	URBAN-CONFORT-FOLDING	348
X-Caliber                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/x-caliber	MTB	1299
Zenit                         	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/zenit	MTB	870
ALMA 29 H10                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1819	MTB	2099
ALMA 29 H30                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1820	MTB	1999
ALMA 29 H50                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1821	MTB	1349
ALMA 29 H70                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1822	MTB	1149
ALMA 29 S10                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1816	MTB	5199
ALMA 29 S30                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1817	MTB	2799
ALMA 29 S50                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1818	MTB	2699
ALMA 29 S TEAM                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1815	MTB	5599
ALMA G10                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1808	MTB	4099
ALMA G TEAM                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1807	MTB	6199
ALMA H10                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1812	MTB	1949
ALMA H30                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1813	MTB	1649
ALMA H50 DAMA                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1823	MTB	1449
ALMA H50                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1814	MTB	1349
ALMA S10                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1809	MTB	2999
ALMA S30                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1810	MTB	2599
ALMA S50                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1811	MTB	1999
Anthem X 0                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2114	MTB	3999
Anthem X 1                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2115	MTB	2799
Anthem X 29er 0               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2121	MTB	3499
Anthem X 29er 1               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2122	MTB	2999
Anthem X 29er 2               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2123	MTB	1999
Anthem X 2                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2117	MTB	1799
Anthem X 2 W                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2117	MTB	1799
Anthem X 3                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2119	MTB	1899
Anthem X 4                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2120	MTB	1599
Anthem X ADV 1                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2112	MTB	3799
Anthem X ADV 2                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2113	MTB	2999
Anthem X ADV SL 0             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2111	MTB	7999
AQUA DAMA T23                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1794	ROAD	699
AQUA DAMA TTG                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1793	ROAD	1059
AQUA T105                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1789	ROAD	1159
AQUA T23 Fitness              	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1803	ROAD	629
AQUA T23                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1792	ROAD	699
AQUA TSR Fitness              	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1802	ROAD	829
AQUA TSR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1791	ROAD	799
AQUA TTG Fitness              	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1801	ROAD	999
AQUA TTG                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1790	ROAD	999
Aspiro Hybrid 1               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2089	URBAN-CONFORT-FOLDING	1799
Aspiro Hybrid 1 W             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2090	URBAN-CONFORT-FOLDING	1799
Audacio 200                   	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1972	ROAD	711
Audacio 200 L                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1973	ROAD	711
Audacio 300                   	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1974	ROAD	915
Audacio 400 CP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1975	ROAD	1016
Audacio 400 L                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1977	ROAD	1016
Audacio 400 TP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1976	ROAD	1016
Audacio 500 CP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1978	ROAD	1423
Audacio 500 TP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1979	ROAD	1423
Audacio 700                   	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1980	ROAD	1728
AVAIL 1                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2078	ROAD	1199
AVAIL Composite 1             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2077	ROAD	3299
BAD BOY 2                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2263	URBAN-CONFORT-FOLDING	1599
BAD BOY 3                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2264	URBAN-CONFORT-FOLDING	1199
BAD BOY 4                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2265	URBAN-CONFORT-FOLDING	1099
BAD BOY 6                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2266	URBAN-CONFORT-FOLDING	899
BAD BOY 7                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2267	URBAN-CONFORT-FOLDING	699
BAD BOY 8                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2268	URBAN-CONFORT-FOLDING	1399
BAD GIRL 1                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2269	URBAN-CONFORT-FOLDING	1399
BAD GIRL 2                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2270	URBAN-CONFORT-FOLDING	949
BL20                          	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2358	MTB	329
BL24                          	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2357	MTB	349
BLACK 26"                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2044	URBAN-CONFORT-FOLDING	385
BLWD 2                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2083	URBAN-CONFORT-FOLDING	469
BLWD 2 W                      	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2084	URBAN-CONFORT-FOLDING	469
Boulevard A10                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1886	URBAN-CONFORT-FOLDING	829
Boulevard A20                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1888	URBAN-CONFORT-FOLDING	709
Boulevard A30                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1890	URBAN-CONFORT-FOLDING	609
Boulevard A40                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1892	URBAN-CONFORT-FOLDING	499
Boulevard A50                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1894	URBAN-CONFORT-FOLDING	399
Boulevard UNI A10             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1895	URBAN-CONFORT-FOLDING	319
Boulevard UNI F10             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1896	URBAN-CONFORT-FOLDING	279
Boulevard UNI F20             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1897	URBAN-CONFORT-FOLDING	229
Boulevard UNI H10             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1885	URBAN-CONFORT-FOLDING	829
Boulevard UNI H20             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1887	URBAN-CONFORT-FOLDING	709
Boulevard UNI H30             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1889	URBAN-CONFORT-FOLDING	609
Boulevard UNI H40             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1891	URBAN-CONFORT-FOLDING	499
Boulevard UNI H50             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1893	URBAN-CONFORT-FOLDING	399
Bowery                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2079	URBAN-CONFORT-FOLDING	599
BRASS 1                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2157	MTB	629
BRASS 2                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2158	MTB	539
Burgundy                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2046	URBAN-CONFORT-FOLDING	609
Caad10 105                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2194	ROAD	1499
Caad10 105 W C                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2194	ROAD	1499
Caad10 Dura-ace               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2191	ROAD	2799
Caad10 Ultegra                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2192	ROAD	1799
CAAD8 Tiagra                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2196	ROAD	999
CAADX Tiagra                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2213	ROAD	1099
CARPE H10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1877	URBAN-CONFORT-FOLDING	929
CARPE H20                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1878	URBAN-CONFORT-FOLDING	829
CARPE H30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1879	URBAN-CONFORT-FOLDING	699
CARPE H40                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1880	URBAN-CONFORT-FOLDING	599
CARPE H50                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1881	URBAN-CONFORT-FOLDING	499
CARPE H60                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1882	URBAN-CONFORT-FOLDING	399
Compair                       	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1825	MTB	819
DAKAR                         	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1829	MTB	399
DEFY 2                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2075	ROAD	999
DEFY 3                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2076	ROAD	849
DEFY Advanced SL 0            	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2072	ROAD	6999
DEFY Composite 1              	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2073	ROAD	2199
DEFY Composite 3              	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2074	ROAD	1499
DH 720                        	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2038	MTB	3966
DH 920 TEAM                   	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2040	MTB	6611
DIEM S10                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1875	URBAN-CONFORT-FOLDING	2099
DIEM S20                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1876	URBAN-CONFORT-FOLDING	1699
DUDE A10                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1883	URBAN-CONFORT-FOLDING	899
DUDE A20                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1884	URBAN-CONFORT-FOLDING	699
Escape Hybrid 2               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2091	URBAN-CONFORT-FOLDING	1599
Escape Hybrid 2 W             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2092	URBAN-CONFORT-FOLDING	1599
E-series 1 MENS               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2260	URBAN-CONFORT-FOLDING	2899
E-series 1 WOMEN              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2261	URBAN-CONFORT-FOLDING	2899
Expression DX W               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2087	URBAN-CONFORT-FOLDING	399
Expression                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2086	URBAN-CONFORT-FOLDING	399
FLASH ALLOY 29er 1            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2245	MTB	2199
FLASH ALLOY 29er 2            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2246	MTB	1899
FLASH ALLOY 29er 3            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2247	MTB	1499
FLASH Carbon 29er 1           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2242	MTB	4699
FLASH Carbon 29er 2           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2243	MTB	3699
FLASH Carbon 29er 3           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2244	MTB	2699
FLASH Carbon 29er ultimate    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2241	MTB	7999
FLASH Carbon 4                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2239	MTB	2299
FLASH Carbon 4Z               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2240	MTB	2399
FLASH HM Carbon 1             	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2237	MTB	5999
FLASH HM Carbon 2             	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2238	MTB	3999
FLASH HM Carbon Ultimate      	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2236	MTB	7499
Folding A10                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1898	URBAN-CONFORT-FOLDING	399
Folding A20                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1899	URBAN-CONFORT-FOLDING	349
Folding F10                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1900	URBAN-CONFORT-FOLDING	299
Froggy 218                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2035	MTB	2033
Froggy 318                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2036	MTB	2339
Froggy 518                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2037	MTB	3559
FS01 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2334	MTB	5499
FS01 XTR                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2333	MTB	6499
FS01 XX                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2332	MTB	7999
FS02 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2335	MTB	3899
FS02 Xt-slx                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2336	MTB	2999
FSX 24                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1398	KIDS	245
GLORY 0                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2135	MTB	4999
GLORY 1                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2136	MTB	3699
GLORY 2                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2137	MTB	2899
GROW 0                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2363	KIDS	179
GROW 1                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2364	KIDS	239
GROW 2 1V                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2365	KIDS	249
GROW 2 7V                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2366	KIDS	259
Halfway 1                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2085	URBAN-CONFORT-FOLDING	799
Hooligan                      	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2271	URBAN-CONFORT-FOLDING	899
ICE LADY                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2054	URBAN-CONFORT-FOLDING	477
ICE                           	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2053	URBAN-CONFORT-FOLDING	477
IMPEC DURA ACE DI2            	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2292	ROAD	10499
IMPEC SRAM RED                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2294	ROAD	8499
IMPEC Ultegra                 	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2293	ROAD	8999
IMPEC Ultegra DI2             	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2293	ROAD	8999
IRATI DAMA                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1832	MTB	829
IRON LADY                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2058	URBAN-CONFORT-FOLDING	813
IRON                          	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2057	URBAN-CONFORT-FOLDING	813
Jasmine 14"                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1389	KIDS	159
Jasmine 16"                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1390	KIDS	165
Jasmine 18"                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1391	KIDS	169
Jekyll Carbon 1               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2216	MTB	5999
Jekyll Carbon 2               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2217	MTB	4499
LADY BIRD 20                  	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1400	KIDS	179
LADY SWAN 24                  	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1401	KIDS	215
LOKIZ DAMA                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1833	MTB	669
LOOPY 24 SUSP                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1395	KIDS	195
LOOPY                         	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1394	KIDS	185
Method 01                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2172	URBAN-CONFORT-FOLDING	469
Method 02                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2173	URBAN-CONFORT-FOLDING	399
MODEM                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2174	URBAN-CONFORT-FOLDING	439
MX 14"                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1386	KIDS	149
MX 16"                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1387	KIDS	155
MX 18"                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1388	KIDS	159
MX 20 DIRT                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2367	KIDS	249
MX 20                         	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1396	KIDS	195
MX 20 TEAM                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2369	KIDS	329
MX 20 XC                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2368	KIDS	269
MX 24 DIRT                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2370	KIDS	259
MX 24                         	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1397	KIDS	229
MX 24 TEAM                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2372	KIDS	399
MX 24 XC                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2371	KIDS	279
OCCAM H10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2288	MTB	2799
OCCAM H30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2289	MTB	2599
OCCAM H30X                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2289	MTB	2599
OCCAM H50                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2291	MTB	1699
OCCAM S10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2284	MTB	5999
OCCAM S30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2285	MTB	4499
OCCAM S30X                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2286	MTB	3499
OCCAM S50                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=2287	MTB	2999
OIZ Carbon 2                  	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1839	MTB	3699
OIZ Carbon 3                  	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1840	MTB	2299
OIZ Carbon TEAM               	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1838	MTB	5999
ONIX LADY                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2056	URBAN-CONFORT-FOLDING	640
ONIX                          	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2055	URBAN-CONFORT-FOLDING	640
ORCA B105 Fitness             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1800	ROAD	1899
ORCA B105                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1782	ROAD	1899
ORCA BLI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1779	ROAD	3199
ORCA BLT                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1781	ROAD	2449
ORCA BTH                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1780	ROAD	2399
ORCA DAMA B105                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1788	ROAD	1899
ORCA DAMA BLI2                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1786	ROAD	3199
ORCA DAMA BLT                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1787	ROAD	2449
ORCA DAMA SFR                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1783	ROAD	3599
ORCA DAMA SLT                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1785	ROAD	3449
ORCA DAMA STH                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1784	ROAD	3399
ORCA GDI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1763	ROAD	9299
ORCA GDR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1764	ROAD	6799
ORCA GFR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1767	ROAD	4699
ORCA GLI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1769	ROAD	5249
ORCA GLT                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1770	ROAD	4599
ORCA GRC                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1765	ROAD	7399
ORCA GRD                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1766	ROAD	6399
ORCA GTH                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1768	ROAD	4499
ORCA SDI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1771	ROAD	6999
ORCA SDR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1774	ROAD	5199
ORCA SFR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1775	ROAD	3599
ORCA SLI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1777	ROAD	4249
ORCA SLT                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1778	ROAD	3449
ORCA SRC                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1773	ROAD	6399
ORCA SRD                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1772	ROAD	4699
ORCA STH                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1776	ROAD	3399
ORDU GDI2                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1795	ROAD	10199
ORDU GDR                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1796	ROAD	7299
ORDU GLT                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1797	ROAD	4699
ORDU S105                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1799	ROAD	2499
ORDU SLT                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1798	ROAD	3149
Paradise 26                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1402	KIDS	299
PEARL                         	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2045	URBAN-CONFORT-FOLDING	406
Pellejo CHILY                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1836	MTB	699
Pellejo HOT                   	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1837	MTB	549
Pellejo Pepper                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1835	MTB	999
PR01 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2311	ROAD	2899
PR02 105                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2312	ROAD	1449
PRO RACE 100                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2004	MTB	1016
PRO RACE 200                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2005	MTB	1271
PRO RACE 200 L                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2006	MTB	1271
PRO RACE 229                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2012	MTB	1016
PRO RACE 300                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2007	MTB	1728
PRO RACE 400                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2008	MTB	2237
PRO RACE 500                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2009	MTB	2237
PRO RACE 529                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2013	MTB	1627
PRO RACE 700                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2010	MTB	3254
PRO RACE 929                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2014	MTB	3254
PRO RACE TEAM                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2011	MTB	6102
QUICK CX 1 / MIXTE            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2276	URBAN-CONFORT-FOLDING	1299
QUICK CX 2 / MIXTE            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2277	URBAN-CONFORT-FOLDING	999
QUICK CX 3 / MIXTE            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2278	URBAN-CONFORT-FOLDING	699
QUICK CX SPEED 1              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2272	URBAN-CONFORT-FOLDING	2399
QUICK CX SPEED 2 / WOMEN      	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2273	URBAN-CONFORT-FOLDING	1199
QUICK CX SPEED 3 / WOMEN      	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2274	URBAN-CONFORT-FOLDING	799
QUICK CX SPEED 8 / WOMEN      	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2275	URBAN-CONFORT-FOLDING	849
RAID 200                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1997	MTB	508
RAID 300                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1998	MTB	609
RAID 400                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1999	MTB	711
RAID 400 L                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2000	MTB	711
RAID 500                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2001	MTB	864
RAID 700                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2002	MTB	965
RAID 700 L                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2003	MTB	965
Rallon 10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1843	MTB	5199
Rallon 30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1844	MTB	3499
Rallon 50                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1845	MTB	2599
Rallon 70                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1846	MTB	1999
Rallon X10                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1841	MTB	5099
Rallon X30                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1842	MTB	2899
RAPT 1.1                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2039	MTB	457
RAPT 1.2                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2041	MTB	558
RAPT 2.1                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2042	MTB	813
RAPT 2.2                      	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2043	MTB	965
RAVEL 26 A10 DAMA             	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1874	URBAN-CONFORT-FOLDING	349
RAVEL 26 A10                  	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1873	URBAN-CONFORT-FOLDING	349
RAVEL H10 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1864	URBAN-CONFORT-FOLDING	1029
RAVEL H10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1863	URBAN-CONFORT-FOLDING	1029
RAVEL H20 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1866	URBAN-CONFORT-FOLDING	829
RAVEL H20                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1865	URBAN-CONFORT-FOLDING	829
RAVEL H30 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1868	URBAN-CONFORT-FOLDING	599
RAVEL H30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1867	URBAN-CONFORT-FOLDING	599
RAVEL H40 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1870	URBAN-CONFORT-FOLDING	499
RAVEL H40                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1869	URBAN-CONFORT-FOLDING	499
RAVEL H50 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1872	URBAN-CONFORT-FOLDING	359
RAVEL H50                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1871	URBAN-CONFORT-FOLDING	359
REIGN 0                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2149	MTB	3499
REIGN 1                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2150	MTB	2599
REIGN 2                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2151	MTB	1999
REIGN X 2                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2148	MTB	2599
REVEL 0 DISC W                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2161	MTB	659
REVEL 1 DISC                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2162	MTB	569
REVEL 1 DISC W                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2162	MTB	569
REVEL 2                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2164	MTB	449
REVEL 2 Street                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2165	MTB	449
REVEL 2 W                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2166	MTB	449
REVEL 3 DISC                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=1635	MTB	469
REVEL 3 DISC W                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2167	MTB	449
REVEL 3                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=1635	MTB	469
REVEL 4                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2170	MTB	349
REVEL 4 Street                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2171	MTB	369
REVEL LTD 0                   	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2159	MTB	849
REVEL LTD 1                   	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2160	MTB	699
RM01 SRAM RED                 	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2302	ROAD	3999
RM01 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2301	ROAD	4499
RM01 Ultegra DI2              	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2301	ROAD	4499
ROAM 1 DISC                   	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2097	URBAN-CONFORT-FOLDING	649
ROAM 2                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2098	URBAN-CONFORT-FOLDING	539
ROAM 3                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2099	URBAN-CONFORT-FOLDING	449
ROAM 3 W                      	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2100	URBAN-CONFORT-FOLDING	449
Rocker 1S                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1392	KIDS	165
Rocker 6S SUSP                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1393	KIDS	179
ROCK LADY                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2052	URBAN-CONFORT-FOLDING	375
ROCK                          	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2051	URBAN-CONFORT-FOLDING	375
RZ ONE Twenty 1               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2223	MTB	2199
RZ ONE Twenty 2               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2224	MTB	1899
RZ ONE Twenty 3               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2225	MTB	1699
RZ ONE Twenty XLR 1           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2221	MTB	3499
RZ ONE Twenty XLR 2           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2222	MTB	2799
Satellite                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1826	MTB	719
SATE                          	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1826	MTB	719
Scalpel 1                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2229	MTB	5999
Scalpel 29er 3                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2234	MTB	2499
Scalpel 29er 4                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2235	MTB	1999
Scalpel 29er carbon 1         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2232	MTB	5999
Scalpel 29er carbon 2         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2233	MTB	3999
Scalpel 2                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2230	MTB	4299
Scalpel 3                     	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2231	MTB	3299
Scalpel Ultimate              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2228	MTB	7999
SE01 Alivio-deore             	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2353	MTB	699
SE01 Deore-slx                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2352	MTB	999
Sedona DX                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2101	URBAN-CONFORT-FOLDING	449
Sedona DX W                   	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2101	URBAN-CONFORT-FOLDING	449
SEEK 1                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2080	URBAN-CONFORT-FOLDING	899
SEEK 2                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2081	URBAN-CONFORT-FOLDING	699
SEEK 3                        	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2082	URBAN-CONFORT-FOLDING	549
Sensium 100 L                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1983	ROAD	1728
Sensium 100 TP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1982	ROAD	1728
Sensium 300 CP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1984	ROAD	2542
Sensium 300 TP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1985	ROAD	2542
Sensium 400 CP                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1986	ROAD	3051
SF01 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2337	MTB	3699
SF01 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2338	MTB	2999
SF02 Deore-slx                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2341	MTB	1599
SF02 Slx-xt                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2340	MTB	1999
SF02 Xt-slx                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2339	MTB	2499
SF29 SLX                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2351	MTB	1999
SF29 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2350	MTB	3499
SH 01 WOMEN                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2354	MTB	2199
Shaper 100                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1965	ROAD	508
Shaper 100 L                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1966	ROAD	508
Shaper 300                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1967	ROAD	711
Shaper 300 L                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1968	ROAD	711
Shaper 500                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1969	ROAD	813
Shaper 700                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1970	ROAD	1220
Shaper 900                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1971	ROAD	2033
Sherpa                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1827	MTB	599
SL01 105                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2306	ROAD	2099
SL01 Tiagra                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2307	ROAD	1799
SL01 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2304	ROAD	3999
SL01 Ultegra DI2              	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2304	ROAD	3999
SLICE 4 FORCE                 	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2206	ROAD	2699
SLR01 DURA ACE                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2296	ROAD	7999
SLR01 DURA ACE DI2            	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2296	ROAD	7999
SLR01 SRAM RED                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2299	ROAD	4999
SLR01 Ultegra                 	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2298	ROAD	5299
SLR01 Ultegra DI2             	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2298	ROAD	5299
SPEED 100                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2047	URBAN-CONFORT-FOLDING	457
SPEED 200                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2048	URBAN-CONFORT-FOLDING	558
SPEED 300                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2049	URBAN-CONFORT-FOLDING	915
SPEED 400                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2050	URBAN-CONFORT-FOLDING	1220
SPICY 316                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2032	MTB	2339
SPICY 516                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2033	MTB	3254
SPICY 916                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2034	MTB	5696
SPORT A10 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1856	URBAN-CONFORT-FOLDING	499
SPORT A10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1855	URBAN-CONFORT-FOLDING	499
SPORT A20 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1858	URBAN-CONFORT-FOLDING	459
SPORT A20                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1857	URBAN-CONFORT-FOLDING	459
SPORT A30 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1860	URBAN-CONFORT-FOLDING	399
SPORT A30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1859	URBAN-CONFORT-FOLDING	399
SPORT A40 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1862	URBAN-CONFORT-FOLDING	369
SPORT A40                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1861	URBAN-CONFORT-FOLDING	369
SPORT H10 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1848	URBAN-CONFORT-FOLDING	1349
SPORT H10                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1847	URBAN-CONFORT-FOLDING	1349
SPORT H20 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1850	URBAN-CONFORT-FOLDING	1049
SPORT H20                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1849	URBAN-CONFORT-FOLDING	1049
SPORT H30 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1852	URBAN-CONFORT-FOLDING	799
SPORT H30                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1851	URBAN-CONFORT-FOLDING	799
SPORT H40 DAMA                	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1854	URBAN-CONFORT-FOLDING	699
SPORT H40                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1853	URBAN-CONFORT-FOLDING	699
SR01 105                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2309	ROAD	1299
SR01 Tiagra                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2310	ROAD	1099
SR01 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2308	ROAD	1799
STP                           	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2152	MTB	1299
SUA DAMA                      	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1834	MTB	559
SUPER SIX 105                 	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2188	ROAD	2099
Supersix EVO DI2              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=1929	ROAD	8499
Supersix EVO Dura-ace         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=1930	ROAD	5699
Supersix EVO SRAM RED         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=1931	ROAD	4699
Supersix EVO TEAM             	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=1928	ROAD	7999
SUPER SIX SRAM APEX           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2189	ROAD	1899
SUPER SIX Ultegra             	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2186	ROAD	3899
SUPER SIX Ultegra DI2         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2186	ROAD	3899
SUPER SIX Ultegra W C         	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2190	ROAD	2799
Superx RIVAL                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2211	ROAD	2199
Superx SRAM RED               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2209	ROAD	3999
Superx Ultegra                	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2210	ROAD	2599
Synapse ALLOY Tiagra W        	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2205	ROAD	1099
Synapse Carbon 105            	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2202	ROAD	2099
Synapse Carbon 105 T W        	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2203	ROAD	2099
Synapse Carbon APEX           	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2204	ROAD	1899
Synapse Carbon Ultegra        	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2201	ROAD	2799
Synapse Hi-mod Dura-ace       	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2198	ROAD	5199
Synapse Hi-mod SRAM RED       	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2199	ROAD	3999
Synapse Hi-mod Ultegra        	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2200	ROAD	3299
TALON 0                       	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2153	MTB	999
TALON 29er 0                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2155	MTB	949
TALON 29er 1                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2156	MTB	749
TALON 2 W                     	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2154	MTB	749
TCR 1                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2068	ROAD	1199
TCR Advanced 0                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2063	ROAD	3999
TCR Advanced 2                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2064	ROAD	2799
TCR Advanced SL 0             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2059	ROAD	11999
TCR Advanced SL 1             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2061	ROAD	7399
TCR Advanced SL 3             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2062	ROAD	3899
TCR ADV SL RABO               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2060	ROAD	6999
TCR Composite 1               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2065	ROAD	2199
TCR Composite 2               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2066	ROAD	1799
TCR Composite 3               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2067	ROAD	1499
TCX 1                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2096	URBAN-CONFORT-FOLDING	1299
TE01 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2326	MTB	4499
TE01 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2325	MTB	5799
TE01 XTR                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2325	MTB	5799
TE01 Xt-slx                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2328	MTB	2699
TE01 XX                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2324	MTB	6999
TE02 Deore-slx                	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2331	MTB	1299
TE02 Slx-xt                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2330	MTB	1599
TE02 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2329	MTB	1999
TE29 SLX                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2349	MTB	1599
TE29 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2348	MTB	2999
TEAM 24                       	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1399	KIDS	239
Tecnic 100 LADY               	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1996	MTB	396
Tecnic 20 LITE                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1994	KIDS	304
Tecnic 24 LITE                	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1995	KIDS	406
TERRA ALU TTG                 	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1806	ROAD	1249
TERRA T105                    	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1805	ROAD	2099
TERRA TLT                     	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1804	ROAD	2799
Tesoro 0 / MIXTE              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2279	URBAN-CONFORT-FOLDING	1899
Tesoro 1 / MIXTE              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2280	URBAN-CONFORT-FOLDING	1499
Tesoro 2 / MIXTE              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2281	URBAN-CONFORT-FOLDING	1099
Tesoro 3 / MIXTE              	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2282	URBAN-CONFORT-FOLDING	899
TF01 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2343	MTB	5599
TF01 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2342	MTB	7499
TF01 XTR                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2342	MTB	7499
TF02 Slx-xt                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2347	MTB	2999
TF02 X0                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2345	MTB	4499
TF02 XT                       	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2346	MTB	3499
TM01 DURA ACE DI2             	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2313	ROAD	9999
TM01 SRAM RED                 	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2314	ROAD	4999
TM01 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2315	ROAD	3999
TM02 105                      	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2317	ROAD	2499
TM02 Ultegra                  	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2316	ROAD	2999
Toubkal                       	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1830	MTB	349
TRAIL SL 1                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2250	MTB	999
TRAIL SL 29er 2               	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2259	MTB	999
TRAIL SL 2                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2251	MTB	899
TRAIL SL 2 W                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2255	MTB	999
TRAIL SL 3                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2252	MTB	799
TRAIL SL 3 W                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2256	MTB	749
TRAIL SL 4                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2253	MTB	649
TRAIL SL 5                    	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2254	MTB	549
TRAIL SL 5 W                  	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2257	MTB	549
TRAIL SL HS33                 	Cannondale                    	Sanferbike	http://www.sanferbike.com/fichacannondale2.asp?producto=2258	MTB	1299
Trance X 0                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2141	MTB	3499
Trance X 1                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2142	MTB	2699
Trance X 2                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2144	MTB	1999
Trance X 2 W                  	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2144	MTB	1999
Trance X 3                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2146	MTB	1899
Trance X 4                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2147	MTB	1299
Trance X ADV 1                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2139	MTB	3799
Trance X ADV 2                	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2140	MTB	2999
Trance X ADV SL 0             	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2138	MTB	8399
Trinity ADV SL 0              	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2069	ROAD	11999
Trinity Composite 1           	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2070	ROAD	2999
Trinity Composite 2           	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2071	ROAD	2399
Tuareg                        	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1831	MTB	289
VL 01 WOMEN                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2355	MTB	1399
VL 02 WOMEN                   	Bmc                           	Sanferbike	http://www.sanferbike.com/fichabmc.asp?producto=2356	MTB	899
X-control 110                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2015	MTB	1220
X-control 210                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2016	MTB	1423
X-control 310                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2017	MTB	1627
X-control 310 L               	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2018	MTB	1627
Xelius 200 CP                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1988	ROAD	2644
Xelius 200 DB                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1987	ROAD	2644
Xelius 400 CP                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1990	ROAD	3203
Xelius 400 DB                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1989	ROAD	3203
Xelius 700 CP                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1992	ROAD	3559
Xelius 700 DB                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1991	ROAD	3559
Xelius 900 CP                 	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=1993	ROAD	5085
X-flow 312                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2019	MTB	2033
X-flow 312 L                  	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2020	MTB	2033
X-flow 412                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2021	MTB	2746
X-flow 512                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2022	MTB	3254
X-flow 612                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2023	MTB	3966
X-flow 712                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2024	MTB	4983
X-flow 912                    	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2025	MTB	6102
XTC 0                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2131	MTB	1999
XTC 1                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2132	MTB	1349
XTC 29er 0                    	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2134	MTB	2199
XTC 2                         	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2133	MTB	1199
XTC COMP 29er 0               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2129	MTB	2999
XTC COMP 29er 1               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2130	MTB	2199
XTC Composite 0               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2125	MTB	2899
XTC Composite 1               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2126	MTB	2199
XTC Composite 2               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2127	MTB	1799
XTC Composite 3               	Giant                         	Sanferbike	http://www.sanferbike.com/fichagiant2.asp?producto=2128	MTB	1499
ZENIT                         	Orbea                         	Sanferbike	http://www.sanferbike.com/fichaorbea2.asp?producto=1824	MTB	999
ZESTY 214                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2026	MTB	2033
ZESTY 314                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2027	MTB	2542
ZESTY 314 L                   	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2028	MTB	2542
ZESTY 514                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2029	MTB	3254
ZESTY 714                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2030	MTB	4068
ZESTY 914                     	Lapierre                      	Sanferbike	http://www.sanferbike.com/fichalp2.asp?producto=2031	MTB	5085
3700 disc                     	Trek                          	Bicicletas Gil	http://www.bicicletasgil.com/producto/Trek-3700-disc	MTB-FIX	339
Alma 29 h 30                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-29-h-30	MTB-29	1999
Alma 29 h 50                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-29-h-50	MTB-29	1349
Alma 29 h 70                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-29-h-70	MTB-29	1149
Alma g 10                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-g-10	MTB-FIX	4099
Alma h 10                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-h-10	MTB-FIX	1949
Alma h 30                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-h-30	MTB-FIX	1649
Alma h 50                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-h-50	MTB-FIX	1349
Alma s 10                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-s-10	MTB-FIX	2999
Alma s 30                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-s-30	MTB-FIX	2599
Alma s 50                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Alma-s-50	MTB-FIX	1759
Anthem x2                     	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Anthem-x2	MTB-DOUBLE	2299
Anthem x4                     	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Anthem-x4	MTB-DOUBLE	1599
Anthem x advanced 1           	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Anthem-x-advanced-1	MTB-DOUBLE	3799
Aqua T23                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Aqua-T23	ROAD	629
Aqua TTG                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Aqua-TTG	ROAD	999
Boulebar uni H50              	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Boulebar-uni-H50	URBAN-CONFORT-FOLDING	399
Carpe H60                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Carpe-H60	URBAN-CONFORT-FOLDING	399
Comp 29                       	Camber                        	Bicicletas Gil	http://www.bicicletasgil.com/producto/CAMBER-COMP-29	MTB-DOUBLE	2399
Compair                       	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Compair	MTB-FIX	819
dakar disc. Color rojo        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-dakar-disc-Color-rojo	MTB-FIX	349
Dakar                         	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Dakar	MTB-FIX	399
Defy composite 1              	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Defy-composite-1	ROAD	2199
Dogma 2 record shamal         	Pinarello                     	Bicicletas Gil	http://www.bicicletasgil.com/producto/Pinarello-Dogma-2-record-shamal	ROAD	8115
Elite 9.6                     	Trek                          	Bicicletas Gil	http://www.bicicletasgil.com/producto/Trek-Elite-9-6	MTB-FIX	1399
Elite Rival Compact           	Roubaix                       	Bicicletas Gil	http://www.bicicletasgil.com/producto/Roubaix-Elite-Rival-Compact	ROAD	2299
FP due veloce                 	Pinarello                     	Bicicletas Gil	http://www.bicicletasgil.com/producto/Pinarello-FP-due-veloce	ROAD	1900
FP quattro athena             	Pinarello                     	Bicicletas Gil	http://www.bicicletasgil.com/producto/Pinarello-FP-quattro-athena	ROAD	2900
FSR Comp                      	Stumpjumper                   	Bicicletas Gil	http://www.bicicletasgil.com/producto/STUMPJUMPER-FSR-COMP	MTB-DOUBLE	2599
Grow 0                        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Grow-0	KIDS	179
Grow 1                        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Grow-1	KIDS	239
Grow 2                        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Grow-2	KIDS	249
H World                       	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-H-World	MTB-FIX	1399
Irati                         	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Irati	WOMAN	829
Lokit                         	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Lokit	WOMAN	669
Master Hydro                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Master-Hydro	MTB-FIX	799
Master sport                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Master-sport	MTB-FIX	499
Mx 20 dirt                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Mx-20-dirt	KIDS	249
Mx 20 xc                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Mx-20-xc	KIDS	269
Mx 24 dirt                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Mx-24-dirt	KIDS	259
Mx 24 xc                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Mx-24-xc	KIDS	279
Occam h 10                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Occam-h-10	MTB-DOUBLE	2899
Occam h 30                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Occam-h-30	MTB-DOUBLE	1999
Occam h 50                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Occam-h-50	MTB-DOUBLE	1699
Occam s 30                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Occam-s-30	MTB-DOUBLE	4599
Occam s 50                    	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Occam-s-50	MTB-DOUBLE	2999
Oiz carbon 3                  	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Oiz-carbon-3	MTB-DOUBLE	2269
Onix Master 2011              	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Master-Onix-2011	ROAD	1199
Orca BLI2                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Orca-BLI2	ROAD	3199
Orca GRC                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Orca-GRC	ROAD	7399
Orca S 105 Team               	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Orca-S-105-Team	ROAD	2399
Orca SLT                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Orca-SLT	ROAD	2700
Paradise                      	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Paradise	WOMAN	279
Rallon 10                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Rallon-10	MTB-DOUBLE	5199
Rallon 50                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Rallon-50	MTB-DOUBLE	2599
Rallon 70                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Rallon-70	MTB-DOUBLE	1999
Ravel H50 700                 	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Ravel-H50-700	URBAN-CONFORT-FOLDING	359
Ravel sport A40               	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Ravel-sport-A40	URBAN-CONFORT-FOLDING	369
Revel 3 disc                  	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Revel-3-disc	MTB-FIX	449
Revel 3 disc w                	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Revel-3-disc-w	WOMAN	449
Revel ltd 1                   	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Revel-ltd-1	MTB-FIX	699
Roam 1 disc                   	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Roam-1-disc	URBAN-CONFORT-FOLDING	649
Roam 3                        	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Roam-3	URBAN-CONFORT-FOLDING	449
Satellite                     	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Satellite	MTB-FIX	719
Sate                          	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Sate	MTB-FIX	499.0072
Sherpa                        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Sherpa	MTB-FIX	599
Sua                           	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Sua	WOMAN	559
Talon 0                       	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Talon-0	MTB-FIX	999
Talon 29 1                    	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Talon-29-1	MTB-29	749
TCR Aadvanced sl Rabobank     	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-TCR-Aadvanced-sl-Rabobank	ROAD	6999
TCR composite 1               	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-TCR-composite-1	ROAD	2199
TCR composite 3               	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-TCR-composite-3	ROAD	1499
Toubkal                       	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Toubkal	MTB-FIX	349
Trance x2                     	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Trance-x2	MTB-DOUBLE	2299
Trance x4                     	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Trance-x4	MTB-DOUBLE	1195
Trance x advanced 2           	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Trance-x-advanced-2	MTB-DOUBLE	2999
Tuareg                        	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Tuareg	MTB-FIX	279
xtc 1                         	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-xtc-1	MTB-FIX	1349
Xtc 29 0                      	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Xtc-29-0	MTB-29	2199
xtc 2                         	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-xtc-2	MTB-FIX	1199
xtc composite 1               	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-xtc-composite-1	MTB-FIX	2199
Xtc composite 29 0            	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Xtc-composite-29-0	MTB-29	2999
Xtc composite 29 1            	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-Xtc-composite-29-1	MTB-29	2199
xtc composite 2               	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-xtc-composite-2	MTB-FIX	1799
xtc composite 3               	Giant                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Giant-xtc-composite-3	MTB-FIX	1499
Zenit                         	Orbea                         	Bicicletas Gil	http://www.bicicletasgil.com/producto/Orbea-Zenit	MTB-FIX	999
MX 20 Dirt                    	Orbea                         	Mammoth	http://www.mammoth.es/producto/bicicletas/orbea/mx-20-dirt	KIDS	255
Trikester                     	Trek                          	Mammoth	http://www.mammoth.es/producto/bicicletas/trek/trikester	KIDS	152.78999
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

