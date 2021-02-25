{- *** Question 1.1 ***
-- Checks that every element of the list is unique

-- This function  is used to convert the tuple to the array used for the functionality
-- It is used throughout the first question

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

-- Uses the elem function to check that the x element does not appear again in the list else it will return false

isUniqueSet::[Int] -> Bool
isUniqueSet [] = True
isUniqueSet(x:xs)
    |elem x xs = False
    |otherwise = isUniqueSet xs


rule1 :: (Int,Int,Int,Int,Int,Int) -> Bool
rule1(a,b,c,d,e,f) = isUniqueSet(tupletoArray(a,b,c,d,e,f))

main::IO()
main = putStrLn(show(rule1(4,9,3,3,0,7)))
-}

{- *** Question 1.2 ***
--Checks that each alternating element is Odd/Even dependant on the first value

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

--Will return True/False if the value can be dived to remainder 0 (Even)
--else the value is Odd

isNumAlt :: Int -> Bool
isNumAlt x = x `mod` 2 == 0

--Checks alternating values from the list, and checks each value pair are different
--If values both return the same Bool then they are not different

check:: [Int] -> Bool
check [] = True
check [x] = True
check(x:(y:xs))
  | isNumAlt x == isNumAlt y = False
  | otherwise = check (y:xs)

rule2 :: (Int,Int,Int,Int,Int,Int) -> Bool
rule2(a,b,c,d,e,f) = check(tupletoArray(a,b,c,d,e,f))

main::IO()
main = putStrLn(show(rule2(4,9,6,3,0,7)))
-}

{- *** Question 1.3 ***
--Checks that each alternating value differs by more than +/- 2

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

--Checks that the value is within the rule limit

isDiffbyTwo :: Int -> Int -> Bool
isDiffbyTwo x y
    | x+2 < y = False
    | x-2 > y = False
    |otherwise = True

--Checks alternating values from the list, and checks each value pair are different by more than 2
--If values both values are less than 2 apart then it will return False

check:: [Int] -> Bool
check [] = True
check [x] = True
check(x:(y:xs))
  | isDiffbyTwo x y = False
  | otherwise = check (y:xs)

rule3 :: (Int,Int,Int,Int,Int,Int) -> Bool
rule3(a,b,c,d,e,f) = check(tupletoArray(a,b,c,d,e,f))

main::IO()
main = putStrLn(show(rule3(4,9,6,3,0,7)))

-}

{- *** Question 1.4 ***
--Checks the first and middle pairs of digits form numbers that are both multiples
the number formed by the last pair of digits

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

--Takes each index from the array and checks them against each other

funct::Int->Int->Int->Bool
funct a b c =
  if a `mod` c == 0 && b `mod` c == 0 then True  else False

altCheck:: [Int] -> Bool
altCheck [] = True
altCheck(x:xs) = do
  let a = (x)*10 + (xs)!!0
  let b = (xs)!!1*10 + (xs)!!2
  let c  = (xs)!!3*10 + (xs)!!4
  if funct a b c == True then True  else False

rule4 :: (Int,Int,Int,Int,Int,Int) -> Bool
rule4(a,b,c,d,e,f) = altCheck(tupletoArray(a,b,c,d,e,f))

main::IO()
main = putStrLn(show(rule4 (4,9,6,3,0,7)))
-}

{- *** Question 1.5 ***
--gives a list of all possible tuples

arrayTotuple :: [a] -> (a, a, a, a, a, a)
arrayTotuple [u,v,w,x,y,z] = (u,v,w,x,y,z)

--Creates the lists into a list of tuples

pos :: [[a]] -> [(a,a,a,a,a,a)]
pos = map arrayTotuple

--Splits the number into single digits as an array

splitNumberUp :: Integral x => x -> [x]
splitNumberUp 0 = []
splitNumberUp x = splitNumberUp (x `div` 10) ++ [x `mod` 10]

--adds 0 to the front of the array

addzeros::Int-> Int -> [Int]
addzeros x 0 = splitNumberUp x
addzeros x a = [0] ++ addzeros x (a-1)

--Depending on the number, how many 0s to add at the front

minuszeros::Int -> Int
minuszeros x = 6 - length(splitNumberUp x)

-- For the number in the list, will split the value into an array of its digits
-- and then add 0s to the front to make up a 6 digit array

rule5::[Int]->[[Int]]
rule5 [x] = [addzeros x (minuszeros x)]
rule5 (x:xs) = [addzeros x (minuszeros x)] ++ rule5 xs

posibilities::[(Int, Int, Int, Int, Int, Int)]
posibilities = pos(rule5[1..999999])

main::IO()
main = putStrLn(show(posibilities))
-}


{- *** Question 1.6 *** -}

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

isNumber :: Int -> Bool
isNumber x = x `mod` 2 == 0

isDifferbyTwo :: Int -> Int -> Bool
isDifferbyTwo x y
    | x+2 < y = False
    | x-2 > y = False
    |otherwise = True

isMultiple::Int->Int->Int->Bool
isMultiple a b c =
  if a `mod` c == 0 && b `mod` c == 0 then True  else False

rule4:: [Int] -> Bool
rule4 [] = True
rule4(x:xs) = do
  let a = (x)*10 + (xs)!!0
  let b = (xs)!!1*10 + (xs)!!2
  let c  = (xs)!!3*10 + (xs)!!4
  if isMultiple a b c == True then True else False

rule3:: [Int] -> Bool
rule3 [] = True
rule3 [x] = True
rule3(x:(y:xs))
  | isDifferbyTwo x y = False
  | otherwise = rule3 (y:xs)

rule2:: [Int] -> Bool
rule2 [] = True
rule2 [x] = True
rule2(x:(y:xs))
  | isNumber x == isNumber y = False
  | otherwise = rule2 (y:xs)

rule1::[Int] -> Bool
rule1 [] = True
rule1(x:xs)
    |elem x xs = False
    |otherwise = rule1 xs

isSolution :: (Int,Int,Int,Int,Int,Int) -> Bool
isSolution(a,b,c,d,e,f) =
    rule1(tupletoArray(a,b,c,d,e,f))
    && rule2(tupletoArray(a,b,c,d,e,f))
    && rule3(tupletoArray(a,b,c,d,e,f))
    && rule4(tupletoArray(a,b,c,d,e,f))

main::IO()
main =  putStrLn(show(isSolution(4,9,6,3,0,7)))


{-- ***  Using 1.5 to generate the tuples and using 1.6 check if a solution ***

--Possible tuple solutions [(4,9,6,3,0,7),(6,9,2,7,0,3),(8,1,6,3,0,9),(8,1,6,9,0,3),(9,0,3,6,1,8)]

tupletoArray :: (a, a, a, a, a, a) -> [a]
tupletoArray (u,v,w,x,y,z) = [u,v,w,x,y,z]

isNumber :: Int -> Bool
isNumber x = x `mod` 2 == 0

isDifferbyTwo :: Int -> Int -> Bool
isDifferbyTwo x y
    | x+2 < y = False
    | x-2 > y = False
    |otherwise = True

isMultiple::Int->Int->Int->Bool
isMultiple a b c =
  if a `mod` c == 0 && b `mod` c == 0 then True  else False

rule4:: [Int] -> Bool
rule4 [] = True
rule4(x:xs) = do
  let a = (x)*10 + (xs)!!0
  let b = (xs)!!1*10 + (xs)!!2
  let c  = (xs)!!3*10 + (xs)!!4
  if isMultiple a b c == True then True else False

rule3:: [Int] -> Bool
rule3 [] = True
rule3 [x] = True
rule3(x:(y:xs))
  | isDifferbyTwo x y = False
  | otherwise = rule3 (y:xs)

rule2:: [Int] -> Bool
rule2 [] = True
rule2 [x] = True
rule2(x:(y:xs))
  | isNumber x == isNumber y = False
  | otherwise = rule2 (y:xs)

rule1::[Int] -> Bool
rule1 [] = True
rule1(x:xs)
    |elem x xs = False
    |otherwise = rule1 xs

isSolution :: (Int,Int,Int,Int,Int,Int) -> Bool
isSolution(a,b,c,d,e,f) =
    rule1(tupletoArray(a,b,c,d,e,f))
    && rule2(tupletoArray(a,b,c,d,e,f))
    && rule3(tupletoArray(a,b,c,d,e,f))
    && rule4(tupletoArray(a,b,c,d,e,f))

arrayTotuple :: [a] -> (a, a, a, a, a, a)
arrayTotuple [u,v,w,x,y,z] = (u,v,w,x,y,z)

pos :: [[a]] -> [(a,a,a,a,a,a)]
pos = map arrayTotuple

splitNumberUp :: Integral x => x -> [x]
splitNumberUp 0 = []
splitNumberUp x = splitNumberUp (x `div` 10) ++ [x `mod` 10]

addzeros::Int-> Int -> [Int]
addzeros x 0 = splitNumberUp x
addzeros x a = [0] ++ addzeros x (a-1)

minuszeros::Int -> Int
minuszeros x = 6 - length(splitNumberUp x)

rule5::[Int]->[[Int]]
rule5 [x] = [addzeros x (minuszeros x)]
rule5 (x:xs) = [addzeros x (minuszeros x)] ++ rule5 xs

posibilities::[(Int, Int, Int, Int, Int, Int)]
posibilities = pos(rule5[1..999999])

allPossibleTuples::[(Int, Int, Int, Int, Int, Int)]->[(Int, Int, Int, Int, Int, Int)]
allPossibleTuples [] = []
allPossibleTuples (x:xs)
  | isSolution x == True = x:allPossibleTuples xs
  | otherwise = allPossibleTuples xs

main::IO()
main =  putStrLn(show(allPossibleTuples(posibilities)))
-}
