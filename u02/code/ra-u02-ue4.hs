-- ra-u02-ue04.hs
import Debug.Trace

main :: IO ()
main = do
    let x = [ g a b c | a <- bools, b <- bools, c <- bools ]
    print x

g :: Bool -> Bool -> Bool -> Bool
g a b c | trace (toInt a ++ " " ++ toInt b ++ " " ++ toInt c ++ " " ++ toInt (a || not(b) || (a && c)) ) False = False
g a b c = (a || not(b) || (a && c))

toInt :: Bool -> String
toInt = show . fromEnum

bools = [False, True]