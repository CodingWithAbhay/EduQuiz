# 🎓 EduQuiz Smart Contract  

EduQuiz is a fun and interactive **blockchain-based quiz application** built using **Solidity**.  
It enables educators to create quiz questions and allows students to answer them directly on the blockchain — ensuring transparency, fairness, and immutability.  

This project is perfect for **beginners in Web3 development** who want to understand how smart contracts work and how decentralized apps (dApps) can revolutionize learning.

---

![Uploading Screenshot 2025-10-29 135456.png…]()


## 📘 Project Description  

The **EduQuiz** smart contract is a simple yet powerful demonstration of how **education meets blockchain**.  
It lets a quiz creator (the contract owner) add questions and correct answers, while participants can attempt those questions on-chain.  
Each correct answer earns the player points that are permanently recorded on the Ethereum blockchain.  

This project introduces essential concepts like:  
- Ownership and access control in smart contracts  
- Data storage using **structs**, **arrays**, and **mappings**  
- Comparing strings using **keccak256 hashing**  
- Interacting with contracts on **Remix IDE**  

---

## 💡 What It Does  

- 🧑‍🏫 The **quiz owner** adds questions and correct answers.  
- 🧠 **Students** can view questions and answer them.  
- 🏆 Points are automatically awarded for correct answers.  
- 📊 Players can check their scores anytime on-chain.  
- 🔒 All quiz data and results are securely stored on the blockchain.  

---

## ✨ Features  

✅ **Owner Control** – Only the creator can add new questions.  
✅ **Decentralized Quiz** – No central authority, no cheating.  
✅ **Instant Scoring** – Correct answers are rewarded immediately.  
✅ **Transparent Records** – Anyone can verify scores on-chain.  
✅ **Beginner-Friendly** – Clean and easy-to-understand Solidity code.  

---

## 🔗 Deployed Smart Contract  

- **Network:** Ethereum (Testnet / Remix VM)  
- **Contract Address:** [`0xf1f691Ca80B54c8262D7bc5C1e1BC3969454eeFb`](https://etherscan.io/address/0xf1f691Ca80B54c8262D7bc5C1e1BC3969454eeFb)  

---

## 🧩 Smart Contract Code  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EduQuiz {
    // Owner (creator of the quiz)
    address public owner;

    // Each question structure
    struct Question {
        string question;
        string correctAnswer;
    }

    // List of questions
    Question[] public questions;

    // Track player scores
    mapping(address => uint) public scores;

    // Modifier to restrict functions to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the quiz owner!");
        _;
    }

    // Constructor
    constructor() {
        owner = msg.sender;
    }

    // Add a new question (only owner can do this)
    function addQuestion(string memory _question, string memory _correctAnswer) public onlyOwner {
        questions.push(Question(_question, _correctAnswer));
    }

    // Total number of questions
    function getQuestionCount() public view returns (uint) {
        return questions.length;
    }

    // Get question text by index
    function getQuestion(uint index) public view returns (string memory) {
        require(index < questions.length, "Invalid question index");
        return questions[index].question;
    }

    // Student submits an answer
    function answerQuestion(uint index, string memory _answer) public {
        require(index < questions.length, "Invalid question index");

        // Compare strings (keccak256 hash)
        if (keccak256(abi.encodePacked(_answer)) == keccak256(abi.encodePacked(questions[index].correctAnswer))) {
            scores[msg.sender] += 1; // Give 1 point for correct answer
        }
    }

    // View your score
    function getMyScore() public view returns (uint) {
        return scores[msg.sender];
    }
}
