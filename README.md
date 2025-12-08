# Gson User Guide

1. [Overview](#TOC-Overview)
2. [Goals for Gson](#TOC-Goals-for-Gson)
3. [Gson Performance and Scalability](#TOC-Gson-Performance-and-Scalability)
4. [Gson Users](#TOC-Gson-Users)
5. [Using Gson](#TOC-Using-Gson)
   * [Using Gson with Gradle/Android](#TOC-Gson-With-Gradle)
   * [Using Gson with Maven](#TOC-Gson-With-Maven)
   * [Primitives Examples](#TOC-Primitives-Examples)
   * [Object Examples](#TOC-Object-Examples)
   * [Finer Points with Objects](#TOC-Finer-Points-with-Objects)
   * [Nested Classes (including Inner Classes)](#TOC-Nested-Classes-including-Inner-Classes-)
   * [Array Examples](#TOC-Array-Examples)
   * [Collections Examples](#TOC-Collections-Examples)
     * [Collections Limitations](#TOC-Collections-Limitations)
   * [Maps Examples](#TOC-Maps-Examples)
   * [Serializing and Deserializing Generic Types](#TOC-Serializing-and-Deserializing-Generic-Types)
   * [Serializing and Deserializing Collection with Objects of Arbitrary Types](#TOC-Serializing-and-Deserializing-Collection-with-Objects-of-Arbitrary-Types)
   * [Built-in Serializers and Deserializers](#TOC-Built-in-Serializers-and-Deserializers)
   * [Custom Serialization and Deserialization](#TOC-Custom-Serialization-and-Deserialization)
     * [Writing a Serializer](#TOC-Writing-a-Serializer)
     * [Writing a Deserializer](#TOC-Writing-a-Deserializer)
   * [Writing an Instance Creator](#TOC-Writing-an-Instance-Creator)
     * [InstanceCreator for a Parameterized Type](#TOC-InstanceCreator-for-a-Parameterized-Type)
   * [Compact Vs. Pretty Printing for JSON Output Format](#TOC-Compact-Vs.-Pretty-Printing-for-JSON-Output-Format)
   * [Null Object Support](#TOC-Null-Object-Support)
   * [Versioning Support](#TOC-Versioning-Support)
   * [Excluding Fields From Serialization and Deserialization](#TOC-Excluding-Fields-From-Serialization-and-Deserialization)
     * [Java Modifier Exclusion](#TOC-Java-Modifier-Exclusion)
     * [Gson's `@Expose`](#TOC-Gson-s-Expose)
     * [User Defined Exclusion Strategies](#TOC-User-Defined-Exclusion-Strategies)
   * [JSON Field Naming Support](#TOC-JSON-Field-Naming-Support)
   * [Sharing State Across Custom Serializers and Deserializers](#TOC-Sharing-State-Across-Custom-Serializers-and-Deserializers)
   * [Streaming](#TOC-Streaming)
6. [Issues in Designing Gson](#TOC-Issues-in-Designing-Gson)
7. [Future Enhancements to Gson](#TOC-Future-Enhancements-to-Gson)

## <h2 id="TOC-Overview">Overview</h2>

Gson is a Java library that can be used to convert Java Objects into their JSON representation. It can also be used to convert a JSON string to an equivalent Java object.

Gson can work with arbitrary Java objects including pre-existing objects that you do not have source code of.

## <a name="TOC-Goals-for-Gson"></a>Goals for Gson






