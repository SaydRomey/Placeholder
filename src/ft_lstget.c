/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lstget.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/22 11:44:14 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/22 12:15:08 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

// to put in libft?
t_list	*ft_lstget(t_list *lst, int index)
{
	t_list	*tmp;
	int		i;

	i = 0;
	tmp = lst;
	if (tmp == NULL)
		return (NULL);
	if (tmp->next == NULL)
		return (tmp);
	while (tmp != NULL)
	{
		if (i >= index)
			return (tmp);
		tmp = tmp->next;
		i++;
	}
	return (NULL);
}
