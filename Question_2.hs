{- *** Question 2.1 ***
--Will pretty print a list onto separate lines

pretty1::[[Char]] -> String
pretty1 [] = ""
pretty1(x:xs) = x ++ "\n" ++ pretty1 xs

pretty::[[[Char]]] -> String
pretty [] = ""
pretty(x:xs) = pretty1 x ++ "\n" ++ pretty xs

main::IO()
main = putStrLn(pretty [[[ 'a','b' ],[ 'c','d' ]],[[ 'e','f' ],[ 'g','h' ] ],[[ 'i','j'],[ 'k','l' ]]])
-}

{- *** Question 2.2 ***
--Takes a list of points and add # at the co-ordinates of the cell
--Visualises a possibly-infinite sequence of generations on a grid of a given width and height

type Point = ( Int, Int )

glider :: [Point]
glider = [ (0, 2), (1, 3), (2, 1), (2, 2), (2, 3) ]

--Takes the integer values for the grid size and the cells

visualisation::Int-> Int -> [[Point]] -> [[String]]
visualisation a b [x] = [vis a b x]
visualisation a b (x:xs) = [vis a b x] ++ visualisation a b xs

--Calls each row
vis::Int -> Int -> [Point] -> [String]
vis a 1 x= [rows a 1 x]
vis a b x =  vis a (b-1) x ++ [rows a b x]

--each row will check the point is on that row and then find the correct cells

rows::Int -> Int -> [Point] -> String
rows 1 b x = check 1 b x
rows a b x = rows (a-1) b x ++ check a b x

check::Int -> Int -> [Point] -> String
check a b [x] = if checkpoint a b x == "#" then "#" else "."
check a b (x:xs) = if checkpoint a b x == "#" then "#" else check a b xs

--If the row and column is correct a "#" will be entered

checkpoint::Int -> Int -> Point -> String
checkpoint a b x
  | fst(x) == (a-1) && snd(x) == (b-1) = "#"
  | otherwise = ""

main::IO()
main = putStrLn(show(visualisation 5 5 [glider]))
-}

{- *** Question 2.3 *** -}
--Produces a potential-infinite sequence of generations of live cells according to the three rules of evolution
--Pretty prints the list to show the cell evolution

type Point
  = ( Int, Int )

glider::[Point]
glider = [(0, 2), (1, 3), (2, 1), (2, 2), (2, 3)]

spinny::[Point]
spinny = [(1,2),(2,2),(3,2)]

pretty1::[[Char]] -> String
pretty1 [] = ""
pretty1(x:xs) = x ++ "\n" ++ pretty1 xs

pretty::[[[Char]]] -> String
pretty [] = ""
pretty(x:xs) = pretty1 x ++ "\n \n" ++ pretty xs

visualisation::Int-> Int -> [[Point]] -> [[String]]
visualisation a b [x] = [vis a b x]
visualisation a b (x:xs) = [vis a b x] ++ visualisation a b xs

vis::Int -> Int -> [Point] -> [String]
vis a 1 x = [rows a 1 x]
vis a b x =  vis a (b-1) x ++ [rows a b x]

rows::Int -> Int -> [Point] -> String
rows 1 b x = check 1 b x
rows a b x = rows (a-1) b x ++ check a b x

check::Int -> Int -> [Point] -> String
check a b [x] = if checkpoint a b x == "#" then "#" else "."
check a b (x:xs) = if checkpoint a b x == "#" then "#" else check a b xs

checkpoint::Int -> Int -> Point -> String
checkpoint a b x
  | fst(x) == (a-1) && snd(x) == (b-1) = "#"
  | otherwise = ""

--Generates a list of all the points around the cell

neighbours :: Point -> [Point]
neighbours (a,b) = [(a+1,b),(a-1,b),(a,b+1),(a,b-1),(a+1,b+1),(a-1,b-1),(a+1,b-1),(a-1,b+1)]

--Checks the points around the specified cell match any of the alive points

isPointAlive :: [Point] -> Point -> Bool
isPointAlive b p = elem p b

isPointEmpty ::  [Point] -> Point -> Bool
isPointEmpty b p = not (isPointAlive b p)

--Filter function takes all the points that contain live cells from the neighbours
-- returns a list of the cells that are alive around the point

pointsAroundCell::[Point]->Point->[Point]
pointsAroundCell b = filter(isPointAlive b).neighbours

--Takes the length of the cells list that are alive around the point

liveneighbours :: [Point] -> Point->Int
liveneighbours b = length.(pointsAroundCell b)

--If liveneighbours has 2 or 3 cells that are alive around the point, the cell
--is added to the survivors list

survivors :: [Point] -> [Point]
survivors b = [a | a <- b, elem (liveneighbours b a) [2,3]]

--Checks that the point is empty, and checks that the list of live neighbours are 3
-- and therefore birth a new cell (added to list)

births :: [Point] -> [Point]
births b = [p | p <- concat (map neighbours b), isPointEmpty b p,liveneighbours b p == 3]

--Duplicates are generated from births where survivors would also be, removes these

removeduplicates :: Eq a => [a] -> [a]
removeduplicates [] = []
removeduplicates (x:xs)
    | elem x xs = removeduplicates xs
    | otherwise = x:removeduplicates xs

--Takes original points list and returns the evolution of the list

nextgeneration :: [Point] -> [Point]
nextgeneration b = removeduplicates(survivors b ++ births b)

--Iterates the list given in main

evolution :: [Point] -> [[Point]]
evolution g = iterate nextgeneration g

main::IO()
main
  = putStrLn(pretty(take 8(visualisation 5 5 (evolution glider))))
