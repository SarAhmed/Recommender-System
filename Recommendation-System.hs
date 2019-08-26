module FinalHaskell where
import DataSet
import System.Random
import System.IO.Unsafe

randomZeroToX :: Int -> Int
randomZeroToX x= unsafePerformIO (getStdRandom (randomR (0, x)))

createEmptyFreqList :: [a] -> [(a,[b])]
createEmptyFreqList [] = []
createEmptyFreqList (x:xs)= (x,[]):createEmptyFreqList xs

occur :: Eq a=> a ->[[a]]->[[a]] 			
occur a [] = []
occur a (x:xs) |elem a x = x:(occur a xs)
	|otherwise = occur a xs

count1D :: Eq a => a->[a]->Int
count1D a [] = 0
count1D a (x:xs)|a==x = 1+count1D a xs
				|otherwise = count1D a xs
count2D :: Eq a => a->[[a]]->Int
count2D a [] = 0
count2D a (x:xs) = count1D a x + count2D a xs

countAll [] l = []
countAll (x:xs) l|count2D x l ==0  = countAll xs l
	|otherwise = (x,(count2D x l)):countAll xs l
remove a [] = []			 
remove a (x:xs)  | a/=x = x:remove a xs
	|otherwise = xs
remove2 (a,c) [] = []
remove2 (a,c) ((x,b):xs)| a/=x = (x,b):(remove2 (a,c) xs)
	|otherwise = xs
					
getAllUserStatsHelper i ph [] = []
getAllUserStatsHelper i ph (y:ys) = (y,countAll r1 r2): (getAllUserStatsHelper i ph  ys) where (r1 , r2) = ((remove y i),(occur y  ph)) 

getAllUserStats [] = []
getAllUserStats ((a,l):xs) = (a,(getAllUserStatsHelper items l items)):getAllUserStats xs

findCorrectList a ((x,l):xs) | a==x = l
			| otherwise = findCorrectList a xs
						   
countFrequency1D a (x,[]) = 0
countFrequency1D a (b,((x,y):xs))|a==x = y+countFrequency1D a (b,xs)
			|otherwise =  countFrequency1D a (b,xs)
countFrequency2D a [] = 0
countFrequency2D a (x:xs) = countFrequency1D a x + countFrequency2D a xs

freqListItemsHelper l [] = []
freqListItemsHelper l (x:xs) |countFrequency2D x l ==0 = freqListItemsHelper l xs
			|otherwise = (x,(countFrequency2D x l)):freqListItemsHelper l xs
								 
freqListItems a = freqListItemsHelper l items where l = findCorrectList a (getAllUserStats purchasesHistory)

getNeededItemsLists1 ((x,l):xs) a |x == a = (x,l)
			|otherwise = getNeededItemsLists1 xs a
								  
getNeededItemsLists2 l [] = []								  
getNeededItemsLists2 l (x:xs) = (getNeededItemsLists1 l x):(getNeededItemsLists2 l xs)

freqListCart a l = freqListItemsHelper(getNeededItemsLists2 r l) items where r = findCorrectList a (getAllUserStats purchasesHistory)

freqListCartAndItemsHelper1 (a,c) ((x,b):xs)|a==x = (a,b+c)
			|otherwise = freqListCartAndItemsHelper1 (a,c) xs
exists (a,b) [] = False										   
exists (a,b) ((x,c):xs)|a==x = True
			|otherwise = exists (a,b) xs
									   
freqListCartAndItemsHelper2 a l [] l2 = l2
freqListCartAndItemsHelper2 a l (x:xs) l2 |exists x l2 = (freqListCartAndItemsHelper1 x l2):(freqListCartAndItemsHelper2 a l xs (remove2 x l2))
			|otherwise = x:(freqListCartAndItemsHelper2 a l xs l2) 
										 
freqListCartAndItems a l = freqListCartAndItemsHelper2 a l l1 l2 where (l1,l2) = (freqListItems a , freqListCart a l)

getRequiredItems [] [] = []
getRequiredItems ((a,l):xs) ((b,l2):ys) |((l == [])||(l2==[]))  = getRequiredItems xs ys
			|otherwise = a: getRequiredItems xs ys
helper [] l = []										
helper (x:xs) l = (findCorrectList x l ):(helper xs l)

helper2  [] l2 = l2
helper2  (x:xs) l2 |exists x l2 = (freqListCartAndItemsHelper1 x l2):(helper2 xs (remove2 x l2))
			|otherwise = x:(helper2 xs l2)
				   
purchasesIntersectionHelper [] [] [] = []				   
purchasesIntersectionHelper (x:xs) (y:ys) (z:zs) = (z,(helper2 x y)):(purchasesIntersectionHelper xs ys zs)
-- we don't need it now but we will need it in the main functions to get the right input to purchaseIntersection
remove3 l [] = []
remove3 l ((a,x):xs) | l==a = xs
		| otherwise = (a,x):remove3 l xs 
					 
purchasesIntersection l [] = []
purchasesIntersection l ((x,l2):xs) = (purchasesIntersectionHelper (helper r l) (helper r l2 ) r):(purchasesIntersection l xs) where r = getRequiredItems l l2

looponitems (x:xs) l1 l2 = (x,helper2 a b) : looponitems xs l1 l2 where (a,b) = ( (helper x l1) ,(helper x l2))

loopOnRow a []=0
loopOnRow a ((b,c):xs)| b==a = c
		|otherwise =loopOnRow a xs
						
freqListUsersHelper1D a [] =0						
freqListUsersHelper1D a ((_,b):xs)= (loopOnRow a b) + (freqListUsersHelper1D a xs)

freqListUsersHelper2D a [] =0
freqListUsersHelper2D a (x:xs)=freqListUsersHelper1D a x + freqListUsersHelper2D a xs

freqListUsersHelper  [] l =[]
freqListUsersHelper   l []=[]
freqListUsersHelper (x:xs) l|freqListUsersHelper2D x l ==0 =freqListUsersHelper xs l
			|otherwise =(x,freqListUsersHelper2D x l):freqListUsersHelper xs l

freqListUsers a = freqListUsersHelper items d where (c,d)=(getAllUserStats purchasesHistory,purchasesIntersection (findCorrectList a c) (remove3 a c))




-------------------------RECOMMENDATIONS------------------------
repeating x 0 = []
repeating x n = x:repeating x (n-1)

probabilityList [] =[]
probabilityList ((a,b):xs) = (repeating a b )++(probabilityList xs)
recommendBasedOnUsers  a|c == [] =""
						|otherwise = c !!  randomZeroToX ((length c)-1) where (b,c)=(freqListUsers a,probabilityList b)


recommendEmptyCart a |length c == 0 =""
		|otherwise = c !!  randomZeroToX ((length c)-1) where (b,c)=(freqListItems a,probabilityList b)

test a l =b where (b,c)=(freqListCart a l,probabilityList b)

-- 0 should be changed to empty String
test a l =freqListCart a l
recommendBasedOnItemsInCart a l |freqListItems a ==[]=""
			|l==[] =recommendEmptyCart a
			|otherwise = c !!  randomZeroToX ((length c)-1) where (b,c,d)=(freqListCart a l,probabilityList d,freqListCartAndItemsHelper2 1 1 b (freqListItems a) )
								
								
								
recommend a l |use == "" && cart == ""  =items !!  randomZeroToX (5)
	|cart=="" =use
	|use == "" =cart
	|randomZeroToX (1) ==0 =use
	|otherwise = cart where (cart , use) =(recommendBasedOnItemsInCart a l,recommendBasedOnUsers a) 								
	
