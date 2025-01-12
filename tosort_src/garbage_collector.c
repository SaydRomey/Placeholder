/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   garbage_collector.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/08/23 13:03:30 by cdumais           #+#    #+#             */
/*   Updated: 2024/08/23 13:12:10 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

// Garbage Collector
typedef struct s_gc
{
	t_list	*alloc_list;
}			t_gc;

t_gc	*gc_instance(void);
void	gc_register(void *ptr);
void	gc_free_all(void);

/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>

t_gc	*gc_instance(void)
{
	static t_gc	gc;

	return (&gc);
}

void	gc_register(void *ptr)
{
	t_gc *gc;
	t_list *new_node;

	if (!ptr)
		return ;
	
	gc = gc_instance();
	new_node = ft_lstnew(ptr);
	if (!new_node)
	{
		free(ptr);
		return ;
	}
	ft_lstadd_back(&(gc->alloc_list), new_node);
}

void	gc_free_all(void)
{
	t_gc	*gc;
	t_list	*current;
	t_list	*next;

	gc = gc_instance();
	current = gc->alloc_list;
	while (current)
	{
		next = current->next;
		if (current->content)
		free(current->content);
		free(current);
		current = next;
	}
	gc->alloc_list = NULL;
}

/* ************************************************************************** */

#include "libft.h"

int	main(void)
{
	char *str1;
	char *str2;

	str1 = ft_strdup("Hello, world!");
	str2 = ft_strdup("This is a test.");
	// Use str1 and str2
	ft_putendl(str1);
	ft_putendl(str2);

	// Free all allocated memory
	gc_free_all();
	return (0);
}

// *** then add the line after each successful mem aloc in libft.. e.g.:

#include "libft.h"
#include <stdlib.h>

/*
incorporating garbage collector in ft_strdup()
*/
char	*ft_strdup(const char *src)
{
	char *new_str;
	size_t len;
	size_t i;

	if (!src)
		return (NULL);
	len = 0;
	while (src[len] != '\0')
	len++;
	new_str = (char *)malloc(sizeof(char) * (len + 1));
	
	if (!new_str)
		return (NULL);
	gc_register(new_str);
	i = 0;
	while (src[i] != '\0')
	{
		new_str[i] = src[i];
		i++;
	}
	new_str[i] = '\0';
	return (new_str);
}


/*
incorporating garbage collector in ft_split()
*/
char	**ft_split(const char *str, char c)
{
	char	**split;
	size_t	i;
	size_t	j;
	size_t	start;
	size_t	word_count;

	if (!str)
		return (NULL);
	word_count = ft_count_words(str, c);
	split = (char **)malloc(sizeof(char *) * (word_count + 1));
	if (!split)
		return (NULL);
	gc_register(split);
	i = 0;
	j = 0;
	while (i < word_count)
	{
		while (str[j] == c)
		j++;
		start = j;
		while (str[j] && str[j] != c)
			j++;
		split[i] = ft_substr(str, start, j - start);
		gc_register(split[i]);
		i++;
	}
	split[i] = NULL;
	return (split);
}
