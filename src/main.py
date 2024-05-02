import pytest

test_add_table = [
    (0,0,0),
    (1,1,2),
    (3,4,7),
    pytest.param("0", 1, 1, marks=pytest.mark.xfail)
]
@pytest.mark.parametrize("a,b,res", test_add_table)
def test_add(a,b,res):
    assert add(a,b) == res

def add(a: int, b:int) -> int:
    return a + b

if __name__ == "__main__":
    print(add(10, 10))