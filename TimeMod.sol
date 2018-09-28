pragma solidity 0.4.18;

contract Test {
    
    uint start;
    uint timeA;
    uint timeB;
    uint timeC;
    uint number;
     
    /* Time period definitions:
      START        End A         End B         End C
        |Time period A|Time period B|Time period C|After time period C....
        
        where start is time of deployment.
     */
     
    modifier inA() {
        require(now < (start + timeA));
        _;
    }
    
    
    modifier inB() {
        require(now < (start + timeA + timeB) && now > (start + timeA));
        _;
    }
    
    modifier inC() {
        require(now < (start + timeA + timeB + timeC) && now > (start + timeA + timeB));
        _;
    }
    
    modifier afterC () {
        require(now > (start + timeA + timeB + timeC));
        _;
    }
    
    /*
    Time periods set in minutes for testing - can set to hours, days etc.
    input integer for time period in constructor - i.e if time period A is 1 minute input 1.
    */
    
    function Test(uint _timeA, uint _timeB, uint _timeC) public {
        start = now;
        timeA = _timeA * (60 seconds);
        timeB = _timeB * (60 seconds);
        timeC = _timeC * (60 seconds);
    }
    
    //test for function accessible only in time period A
    function testA(uint _number) public inA {
        number = _number;
    }
    
    //test for function accessible only in time period B
    function testB(uint _number) public inB {
        number = _number;
    }
    
    //test for function accessible only in time period C
    function testC(uint _number) public inC {
        number = _number;
    }
    
    //test for function accessible only after time period C has ended
    function testAfterC(uint _number) public afterC {
        number = _number;
    }
    
    function getNumber() public constant returns(uint) {
        return number;
    }
    
}
