/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   singleton.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/09 20:20:09 by cdumais           #+#    #+#             */
/*   Updated: 2024/05/09 20:27:05 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

typedef struct s_info
{
	bool	problem;
	char	*error_msg;
}			t_info;

/* ************************************************************************** */

t_info	*call_info(void)
{
	static t_info	*info;

	if (info == NULL)
	{
		info = ft_calloc(1, sizeof(*info));
		if (!info)
			return (NULL);
	}
	return (info);
}

void	free_info(void)
{
	t_info	*info;

	info = call_info();
	if (info->error_msg)
	{
		free(info->error_msg);
	}
	free(info);
}

bool	there_is_a_problem(void)
{
	return (call_info()->problem);
}

/* ************************************************************************** */

void	set_error(char *str)
{
	t_info	*info;

	info = call_info();
	if (info->error_msg != NULL)
	{
		free(info->error_msg);
		info->error_msg = NULL;
	}
	info->error_msg = ft_strdup(str);
	info->problem = true;
}

void	set_error_arg(char *str, char *arg)
{
	char	*full_error;

	full_error = ft_strjoin_with(str, ": ", arg);
	if (full_error)
	{
		set_error(full_error);
		free(full_error);
	}
}

char	*get_error(void)
{
	t_info	*info;

	info = call_info();
	if (!info->error_msg)
		return ("[error message not set]");
	return (info->error_msg);
}

/*
as requested by the pdf:
"If any misconfiguration of any kind is encountered in the file,
the program must exit properly and return "Error\n"
followed by an explicit error message of your choice.
*/
void	error(void)
{
	ft_putstr_fd("Error\n", STDERR);
	ft_fprintf(STDERR, "%s%s%s\n", RED, get_error(), RESET);
	free_info();
	exit(FAILURE);
}

/*
mlx specific error function, uses 'mlx_errno' to identify error
*/
void	error_mlx(void)
{
	const char	*mlx_error_msg;

	mlx_error_msg = mlx_strerror(mlx_errno);
	set_error((char *)mlx_error_msg);
	error();
}
