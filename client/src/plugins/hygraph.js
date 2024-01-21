import { GraphQLClient } from 'graphql-request';

const hygraphClient = new GraphQLClient(
  'https://api-sa-east-1.hygraph.com/v2/clrm4asx40h9y01w3qaztpy5a/master'
);

export default hygraphClient;