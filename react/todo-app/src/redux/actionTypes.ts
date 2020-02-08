import { Action } from 'redux';

export type AddTodoPayload = {
  text: string;
}

export interface AddTodoAction extends Action {
  type: 'ADD_TODO';
  payload: AddTodoPayload;
}

export const addTodo = (payload: AddTodoPayload): AddTodoAction => {
  return {
    payload,
    type: 'ADD_TODO'
  };
}

export type ToggleTodoPayload = {    // todoをトグルする時に必要なのはどのtodoかの情報くらい
  id: number;
};

export interface ToggleTodoAction extends Action {
  type: 'TOGGLE_TODO';
  payload: ToggleTodoPayload;
}

export const toggleTodo = (payload: ToggleTodoPayload): ToggleTodoAction => {
  return {
      payload,
      type: 'TOGGLE_TODO',
  };
};