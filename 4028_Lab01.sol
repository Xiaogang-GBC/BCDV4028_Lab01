// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

library ArrayUtils {

    // Array sorting
    function sortArray(uint[] memory _array) internal pure returns (uint[] memory) {
        if(_array.length == 0 || _array.length == 1) return _array;
        for (uint i = 0; i < _array.length-1; i++) {
            for (uint j = 0; j < _array.length-1-i; j++) {
                // a temp uint for exchanging value between the two items of the array
                uint temp;
                // swap value
                if (_array[j] > _array[j+1]) {
                    temp = _array[j];
                    _array[j] = _array[j+1];
                    _array[j+1] = temp;
                }
            }
        }
        return _array;
    }

    // removes duplicates from sorted array
    function removeArrayDuplicates(uint[] memory _array) internal pure returns (uint[] memory){
        if(_array.length == 0 || _array.length == 1) return _array;
        
        // define another array to keep unique values
        uint[] memory uniqueArray = new uint[](_array.length);
        uniqueArray[0] = _array[0];
        uint j = 1;
        for(uint i = 0; i < _array.length-1; i++) {
            // if the next item is not equal to the previous one, save it to new array
            if(_array[i] != _array[i+1]) {
                uniqueArray[j++] = _array[i+1];
            }
        }

        //move the array to the right size of a new returning array 
        uint[] memory returnArray = new uint[](j);
        for(uint i = 0; i < j; i++) {
            returnArray[i] = uniqueArray[i];
        }
        return returnArray;
    }
}

contract StudentRegistration {
    using ArrayUtils for uint[];
    
    // initialize the array with initial values
    uint[] public studentArray = [11,75,88,66,23,75,92,11,37,66,56,19];

    function consolidateStudentNumbers() public {
        // check if the array is empty or only with single value
        if (studentArray.length == 0 || studentArray.length == 1) return; 

        studentArray = studentArray.sortArray();      
        studentArray = studentArray.removeArrayDuplicates();     
    }

    // user can set the array manually
    function setStudentArray(uint[] memory _stu) public {
        // reset the array
        studentArray = new uint[](0);
        for(uint i = 0; i < _stu.length; i++) {
            studentArray.push(_stu[i]);
        }
    }

    // this function is only for better readability of the array to observe the value change
    // the default getter requires index and only show one each time
    function getStudentArray() public view returns (uint[] memory){
        return studentArray;
    }
}