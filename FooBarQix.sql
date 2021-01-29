------------------------------------------------------------
-- Programme pour imprimer une série de nombre en appliquant
-- les règles suivantes :
-- if the number is divisible by 3 or contains 3, replace 3 by "Foo";
-- if the number is divisible by 5 or contains 5, replace 5 by "Bar";
-- if the number contains 7, replace by "Qix";
--
--Example: 1 2 FooFoo 4 BarBar Foo Qix 8 Foo Bar
--
--More details:
-- divisors have high precedence, ex: 51 -> FooBar
-- the content is analysed in the order they appear, ex: 53 -> BarFoo
-- 13 contains 3 so we print "Foo"
-- 15 is divisible by 3 and 5 and contains 5, so we print "FooBarBar"
-- 33 contains 3 two times and is divisible by 3, so we print “FooFooFoo”
-- 27 is divisible by 3 and contains 7, so we print "FooQix"-
--
------------------------------------------------------------
CREATE OR REPLACE PROCEDURE P_FOOBARQIX(p_deb IN NUMBER, p_fin IN NUMBER) IS
CC_FOO CONSTANT VARCHAR2(3) := 'Foo';
CC_BAR CONSTANT VARCHAR2(3) := 'Bar';
CC_QIX CONSTANT VARCHAR2(3) := 'Qix';
vv_nbr VARCHAR2( 5);   -- Convertion variable de boucle (i) en chaine de caractères
vv_ret VARCHAR2(25);   -- Résultat à afficher
BEGIN
   FOR i IN p_deb..p_fin LOOP
      BEGIN
         -- Préparer le traitement du nombre et la sortie
         vv_ret := '';
         vv_nbr := TO_CHAR(i, 'FM999');
         -- Vérifier la division par 3 et 5 en premier
         IF MOD(i, 3) = 0 THEN vv_ret := vv_ret||CC_FOO; END IF;
         IF MOD(i, 5) = 0 THEN vv_ret := vv_ret||CC_BAR; END IF;
         -- Vérifier la présence des chiffres 3, 5 et 7
         FOR j IN 1..LENGTH(vv_nbr) LOOP
            BEGIN
               IF    SUBSTR(vv_nbr, j, 1) = '3' THEN vv_ret := vv_ret||CC_FOO;
               ELSIF SUBSTR(vv_nbr, j, 1) = '5' THEN vv_ret := vv_ret||CC_BAR;
               ELSIF SUBSTR(vv_nbr, j, 1) = '7' THEN vv_ret := vv_ret||CC_QIX;
               END IF;
            END;
         END LOOP;
         -- Si la sortie est NULL alors prendre le nombre
         IF vv_ret IS NULL THEN vv_ret := vv_nbr; END IF;
         dbms_output.put_line(vv_ret);
      END;
   END LOOP;
   RETURN;
END P_FOOBARQIX;
