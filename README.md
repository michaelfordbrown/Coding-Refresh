Introduction
=========
A collection of Scripts and Programs to be written to help refresh my Software Coding Skills.
Over the last 3 years, I have been an Applications Support Engineer.
Although this does expose me to a CRM system it has limited coding opportunities.
I have decided that I need to refresh the skills I picked up prior to my current role.

T-SQL Coding
===========

Using basic questions to expand SQL skills.

Qu 1: Joint Session Count

     Write a SQL query to count the number of unique users per day who logged in from 
     both iPhone AND Web (for that day), Where iPhone logs and Web logs are indistinct   
     Relations.

Ref Link: https://github.com/michaelfordbrown/Coding-Refresh/commit/751f7c84e5b0a541377f414a617c39734eec8dcb?branch=751f7c84e5b0a541377f414a617c39734eec8dcb&diff=unified

File: Joint Session.sql

Qu 2: Friend Acceptance Rate

     Write a SQL query to find out the overall friend acceptance rate for each day.
     friend_requests: ds | sender | receiver | action (Sent, accepted, rejected etc).
     DAY(ds) | friend_acceptance_rate(receiver) = accepted(receiver)/total(receiver)
     for each receiver count distent accepter 
     
Ref Link: https://github.com/michaelfordbrown/Coding-Refresh/commit/751f7c84e5b0a541377f414a617c39734eec8dcb?branch=751f7c84e5b0a541377f414a617c39734eec8dcb&diff=unified
