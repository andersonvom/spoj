#include <stdio.h>

#define MAX_LETTERS 90
#define MAX_KEYS 90
#define INF 409500000

int num_keys, num_letters, frequencies[MAX_LETTERS];
char keys[MAX_KEYS], letters[MAX_LETTERS];

int best_price[MAX_KEYS][MAX_LETTERS];
int solution[MAX_KEYS][MAX_LETTERS];

void solve()
{
  int i, j, k, current_price, possible_solution;
  for(i=0 ; i<num_keys ; i++)
    for(j=0 ; j<num_letters ; j++) best_price[i][j] = INF;
    
  for(i=0 ; i<num_keys ; i++)
  {
    if(i == 0) //initialize for first key
    {
      for(j=0 ; j<num_letters ; j++)
      {
        if(j == 0) { 
          best_price[i][j] = frequencies[j]; 
          solution[i][j] = 0; 
        }
        else { 
          best_price[i][j] = best_price[i][j-1] + frequencies[j] * (j+1); 
          solution[i][j] = 0;
        }
      }
      continue;
    }

    for(j=0 ; j<num_letters ; j++)
    {
      if(best_price[i-1][j] < INF)
      {
        current_price = 0;
        for(k=j+1 ; k<num_letters ; k++)
        {
          current_price += frequencies[k] * (k-j);
          possible_solution = best_price[i-1][j] + current_price;
          if(possible_solution < best_price[i][k]) {
            best_price[i][k] = possible_solution;
            solution[i][k] = j+1;
          }
        }
      }
    }
  }
}

void print(int k, int l)
{
  if(k < 0) return;
  print(k-1, solution[k][l]-1);
  printf("%c: ", keys[k]);
  int i;
  for(i=solution[k][l] ; i<=l ; i++)
    printf("%c",letters[i]);
  printf("\n");
}

int main()
{
  int T, current=1;
  int i;
  scanf(" %d",&T);
  while(T--)
  {
    printf("Keypad #%d:\n", current++);
    scanf(" %d %d", &num_keys, &num_letters);
    scanf(" %s", keys);
    scanf(" %s", letters);
    for (i=0 ; i<num_letters ; i++)
      scanf(" %d",&frequencies[i]);

    solve();
    print(num_keys-1, num_letters-1);
    printf("\n");
  }
  return 0;
}
