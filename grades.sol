//"SPDX-License-Identifier: UNLICENSED";
pragma solidity >=0.4.4;
pragma experimental ABIEncoderV2;


//  STUDENT | ID       | GRADE
//  Mario   324234X     10


contract grades{
    
    address public professor;
    
    //Student address to note
    mapping(bytes32 => uint) grades;
    
    string [] reviewsRequested;
    
    //Events
    event set_note_event(bytes32, uint);
    event review_event(string);
    
    constructor(){
        //The professor is the contract owner
        professor = msg.sender;
    }
    
    
    function setNoteToStudent(string memory _idStudent, uint _grade) public isProfessor(msg.sender){
        //id to Hash
        bytes32 hash_idStudent = keccak256(abi.encodePacked(_idStudent));
        
        //Hash Student to grade 
        grades[hash_idStudent] = _grade;
        
        //Emit the event
        emit set_note_event(hash_idStudent, _grade);
    }
    
    
    function getGradeByStudentId(string memory _idStudent) public view returns(uint){
        //id to Hash
        bytes32 hash_idStudent = keccak256(abi.encodePacked(_idStudent));
        
        return grades[hash_idStudent];
        
    }
    
    
    modifier isProfessor(address _address){
        //Checking the contract owner(the owner is the professor)
        require(_address == professor, "Permission denied, you are not the owner");
        _;
    }
    
    
    //function to request a test review
    function requestTestReview(string  memory _idStudent) public{
        reviewsRequested.push(_idStudent);
        emit review_event(_idStudent);
    }
    
    
    //Return the students ids how has requested a review
    function getReviewsRequested() public view isProfessor(msg.sender) returns(string [] memory){
        return reviewsRequested;
    }
    
}
